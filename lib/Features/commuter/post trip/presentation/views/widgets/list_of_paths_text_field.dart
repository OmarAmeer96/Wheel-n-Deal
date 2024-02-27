import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class ListOfPathsTextField extends StatelessWidget {
  const ListOfPathsTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.controller,
    required this.enabled,
    required this.validator,
    required this.onChanged,
    required this.inputType,
  });

  final String hintText;
  final Widget? prefixIcon;
  final bool enabled;
  final Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xfff3f3f3),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          style: Styles.manropeRegular15.copyWith(
            fontSize: 18,
            color: Colors.black,
          ),
          validator: validator,
          keyboardType: inputType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
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
            hintStyle: Styles.manropeBold32.copyWith(
              fontSize: 15,
              color: const Color(0xFFA3A3A3),
            ),
          ),
        ),
      ),
    );
  }
}
