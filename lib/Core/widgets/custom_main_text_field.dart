import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CustomMainTextField extends StatelessWidget {
  const CustomMainTextField({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.enabledBorderColor,
    required this.inputType,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
  });

  final Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final String hintText;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final TextInputType inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      enabled: true,
      keyboardType: inputType,
      style: Styles.poppinsSemiBold16.copyWith(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        floatingLabelStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFFA3A3A3),
        ),
        constraints: const BoxConstraints(
          // maxHeight: 80,
          minHeight: 60,
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        hintText: hintText,
        hintStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFF757575),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: focusedBorderColor, width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: enabledBorderColor, width: 1.0),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
