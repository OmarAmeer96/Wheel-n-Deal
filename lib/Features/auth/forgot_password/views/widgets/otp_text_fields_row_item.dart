import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class OtpTextFieldsRowItem extends StatelessWidget {
  const OtpTextFieldsRowItem({
    super.key,
    required this.onChanged,
  });

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextField(
        onChanged: onChanged,
        style: Styles.manropeExtraBold32.copyWith(fontSize: 22),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: otpTextFieldsRowDecoration(),
      ),
    );
  }

  InputDecoration otpTextFieldsRowDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF4F5F7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFA4A4A4),
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }
}
