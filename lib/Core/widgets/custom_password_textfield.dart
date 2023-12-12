import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    super.key,
    required this.text,
    required this.onChanged,
    required this.controller,
    required this.validator,
  });

  final String text;
  final Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator; // New validator attribute

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool obscureText = true;

  void _togglePasswordIcon() {
    obscureText = !obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Changed to TextFormField to support validation
      controller: widget.controller,
      obscureText: obscureText,
      onChanged: widget.onChanged,
      enabled: true,
      style: Styles.poppinsSemiBold16.copyWith(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        floatingLabelStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFFA3A3A3),
        ),
        constraints: const BoxConstraints(
          maxHeight: 60,
          minHeight: 60,
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        labelText: widget.text,
        labelStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFF757575),
        ),
        hintText: 'Enter Name',
        hintStyle: Styles.poppinsSemiBold16.copyWith(
          color: const Color(0xFFA3A3A3),
        ),
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
          child: SvgPicture.asset(AssetsData.passWord),
        ),
        suffixIcon: InkWell(
          onTap: () {
            _togglePasswordIcon();
          },
          child: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
