import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maraphons/model/colors.dart';
import 'package:maraphons/model/word.dart';

class CustomTimer extends StatefulWidget {
  const CustomTimer({
    required this.endEvent,
    required this.onTimerFinish,
    super.key,
  });

  final DateTime endEvent;
  final Function onTimerFinish;

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  int remaining = 0;
  int secondsRemaining = 0;
  int minutesRemaining = 0;
  int hoursRemaining = 0;
  int daysRemaining = 0;
  late Duration remainingDate;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingDate = widget.endEvent.difference(DateTime.now());
        if (remainingDate.inSeconds > 0) {
          remainingDate -= const Duration(seconds: 1);
          daysRemaining = remainingDate.inDays;
          hoursRemaining = remainingDate.inHours - daysRemaining * 24;
          minutesRemaining = remainingDate.inMinutes -
              ((daysRemaining * 24 + hoursRemaining) * 60);
          secondsRemaining = remainingDate.inSeconds -
              ((daysRemaining * 24 * 60 +
                      hoursRemaining * 60 +
                      minutesRemaining) *
                  60);
        } else {
          // widget.onTimerFinish();
          // timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //startTimer();
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TimerCell(
              time: daysRemaining,
              label: daysRemaining == 1
                  ? Word.day1
                  : [2, 3, 4].contains(daysRemaining)
                      ? Word.day
                      : Word.days,
            ),
            const SizedBox(width: 4),
            TimerCell(
              time: hoursRemaining,
              label: Word.hours,
            ),
            const SizedBox(width: 4),
            TimerCell(
              time: minutesRemaining,
              label: Word.minutes,
            ),
            const SizedBox(width: 4),
            TimerCell(
              time: secondsRemaining,
              label: Word.seconds,
            ),
          ],
        ),
      ),
    );
  }
}

class TimerCell extends StatelessWidget {
  const TimerCell({required this.time, required this.label, super.key});

  final int time;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppColors.goldBackground,
                  blurRadius: 1,
                  blurStyle: BlurStyle.normal,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  AppColors.titleText.withOpacity(0.3),
                  AppColors.titleText.withOpacity(0.8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.center,
              ),
            ),
            child: Center(
              child: Text(
                '$time',
                style: const TextStyle(
                  letterSpacing: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: '1stenterprises3D',
                  color: AppColors.background,
                  fontSize: 48,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppColors.goldBackground,
                  blurRadius: 2,
                  blurStyle: BlurStyle.inner,
                ),
              ],
              color: AppColors.titleText.withOpacity(0.4),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    color: AppColors.background,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
