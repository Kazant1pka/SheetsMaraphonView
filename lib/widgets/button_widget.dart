import 'package:flutter/material.dart';
import 'package:maraphons/model/colors.dart';

class Button extends StatelessWidget {
  const Button({required this.text, required this.onTap, super.key});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColors.background,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(
                color: AppColors.tableHeader,
                width: 2,
              ),
            ),
          )),
      child: Text(
        text,
        maxLines: 1,
        style: const TextStyle(
            color: AppColors.tableText, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
