import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const ButtonWidget({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColor.caribbeanCurrent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
