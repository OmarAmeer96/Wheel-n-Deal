import 'package:flutter/material.dart';

import '../utils/styles.dart';

class CustomTextField extends StatelessWidget {
  final bool isNumeric;
  final TextEditingController controller;
  final dynamic validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String headerTextField;
  final String labelText;
  final bool obscureText;
  final Color labelColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.isNumeric = false,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.headerTextField,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerTextField,
          style: Styles.poppinsRegular.copyWith(color: const Color(0xFFA3A3A3)),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFA4A4A4)),
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelText: labelText,
            labelStyle: Styles.poppinsRegular.copyWith(color: labelColor),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          obscureText: obscureText,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
