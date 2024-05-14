import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool disabled;
  final GlobalKey<FormState>? formKey;

  const ButtonWidget(
      {super.key,
      required this.onPressed,
      required this.text,
      this.disabled = false,
      this.formKey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled
          ? null
          : () {
              if (formKey != null) {
                if (formKey != null && formKey!.currentState != null && formKey!.currentState!.validate()) {
                  onPressed!();
                }
              } else {
                onPressed!();
              }
            },
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: disabled
              ? AppColor.softGray
              : AppColor.white, // Change color when disabled
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
