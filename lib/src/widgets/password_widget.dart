import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';

class PasswordWidget extends StatefulWidget {
  final controller;
  final String hintText;
  final String? Function(String?)? validator;
  final String? errorText;

  const PasswordWidget(
      {super.key, required this.controller, required this.hintText, this.validator, this.errorText});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            errorText: widget.errorText,
            errorStyle: const TextStyle(
                color: AppColor.white, fontFamily: AppConstants.fontFamily),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.gray)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray),
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                color: AppColor.gray, fontFamily: AppConstants.fontFamily),
            filled: true,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColor.gray,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: widget.validator,
        ));
  }
}
