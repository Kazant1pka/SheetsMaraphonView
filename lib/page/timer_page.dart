import 'package:flutter/material.dart';
import 'package:maraphons/model/colors.dart';
import 'package:maraphons/model/word.dart';
import 'package:maraphons/widgets/app_bar_title.dart';
import 'package:maraphons/widgets/timer.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({required this.endEvent, super.key});

  final DateTime endEvent;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  void _showSnackbar() {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width / 2,
      shape: const CircleBorder(
          side: BorderSide(width: 5, color: AppColors.silverBackground)),
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            Word.endTimer.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'PlayfairDisplay',
              wordSpacing: 5,
              fontSize: 48,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.goldBackground,
      duration: const Duration(
        seconds: 1,
      ),
      action: SnackBarAction(label: '✖', onPressed: () {}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBarTitle(
        titleText: Word.timer,
        size: 22,
        height: MediaQuery.of(context).size.height,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, bottom: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/timer_fon.png'),
              fit: BoxFit.fill,
              opacity: 0.9,
            ),
            border: Border.all(width: 2),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.1,
              right: 8,
              left: 8,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomTimer(
                endEvent: widget.endEvent,
                onTimerFinish: () {
                  _showSnackbar();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
