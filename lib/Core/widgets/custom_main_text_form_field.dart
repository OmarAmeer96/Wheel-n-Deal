import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class CustomMainTextFormField extends StatelessWidget {
  const CustomMainTextFormField({
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
    this.labelText,
    this.contentPadding = 19,
    this.fillColor,
    this.suffixIconOnTap,
    this.enabled = true,
    this.disabledBorder,
  });

  final Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final String hintText;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final InputBorder? disabledBorder;
  final TextInputType inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? labelText;
  final double contentPadding;
  final Color? fillColor;
  final void Function()? suffixIconOnTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: inputType,
      style: Styles.poppinsSemiBold16.copyWith(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        // filled: true,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: contentPadding),
        floatingLabelStyle: Styles.poppinsSemiBold16.copyWith(
          color: kPrimaryColor,
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
        labelText: labelText,
        labelStyle: Styles.poppinsSemiBold16.copyWith(
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
        disabledBorder: disabledBorder,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: prefixIcon,
        ),
        suffixIcon: GestureDetector(
          onTap: suffixIconOnTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: suffixIcon,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
