import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class CustomVisaTextField extends StatelessWidget {
  const CustomVisaTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    required this.controller,
    required this.enabled,
    required this.validator,
    required this.onChanged,
  });

  final String labelText;
  final String hintText;
  final Widget? prefixIcon;
  final bool enabled;
  final Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      style: Styles.manropeRegular15.copyWith(
        fontSize: 15,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: Styles.manropeRegular15.copyWith(
          fontSize: 18,
          color: const Color(0xFF191D31),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        hintStyle: Styles.manropeRegular14.copyWith(
          fontSize: 15,
          color: const Color(0xFFA3A3A3),
        ),
      ),
    );
  }
}
