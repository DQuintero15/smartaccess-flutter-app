import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';

class TextFieldWidget extends StatelessWidget {
  final controller;
  final String hintText;
  final TextInputType? type;
  final String? Function(String?)? validator;
  final String? errorText;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.type,
    this.validator,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            errorText: errorText,
            errorStyle: const TextStyle(
                color: AppColor.lightGray, fontFamily: AppConstants.fontFamily),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.gray)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: AppColor.gray, fontFamily: AppConstants.fontFamily),
            filled: true),
        keyboardType: type,
      ),
    );
  }
}
