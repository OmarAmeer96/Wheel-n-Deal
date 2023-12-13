import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CustomForgotPassTextField extends StatelessWidget {
  const CustomForgotPassTextField({
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
      keyboardType: TextInputType.phone,
      style: Styles.poppinsSemiBold16.copyWith(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        floatingLabelStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFFA3A3A3),
        ),
        constraints: const BoxConstraints(
          minHeight: 60,
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        hintText: 'Phone Number',
        hintStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFF757575),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 21),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "+20",
                style: Styles.poppinsSemiBold16,
              ),
              const SizedBox(
                width: 7,
              ),
              Image.asset(
                AssetsData.egyptFlagPng,
                height: 26,
              ),
            ],
          ),
        ),
      ),
      validator: validator,
    );
  }
}
