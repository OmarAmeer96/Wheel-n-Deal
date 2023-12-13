import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CustomEmailTextField extends StatelessWidget {
  const CustomEmailTextField({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.validator,
  });

  final Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      enabled: true,
      style: Styles.poppinsSemiBold16.copyWith(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        floatingLabelStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFFA3A3A3),
        ),
        constraints: const BoxConstraints(
          maxHeight: 80,
          minHeight: 80,
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        hintText: 'Enter Name',
        hintStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFF757575),
        ),
        // labelText: 'Username',
        // labelStyle: Styles.poppinsSemiBold16.copyWith(
        //   color: const Color(0xFF757575),
        // ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFA3A3A3), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xff55433c), width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFA3A3A3), width: 1.0),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SvgPicture.asset(AssetsData.userName),
        ),
      ),
      validator: validator,
    );
  }
}
