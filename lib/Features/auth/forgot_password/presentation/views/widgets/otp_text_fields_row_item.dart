import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class OtpTextFieldsRowItem extends StatefulWidget {
  const OtpTextFieldsRowItem({
    super.key,
    required this.onChanged,
  });

  final Function(String) onChanged;

  @override
  State<OtpTextFieldsRowItem> createState() => _OtpTextFieldsRowItemState();
}

class _OtpTextFieldsRowItemState extends State<OtpTextFieldsRowItem> {
  final _form = GlobalKey<FormState>();

  Color textFieldBottomBorderColor = const Color(0xFFA3A3A3);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Stack(
        children: [
          SizedBox(
            height: 68,
            width: 64,
            child: TextFormField(
              onChanged: (value) {
                if (value.isEmpty) {
                  textFieldBottomBorderColor = const Color(0xFFA3A3A3);
                } else {
                  textFieldBottomBorderColor = kPrimaryColor;
                }
                setState(() {});
                widget.onChanged(value);
              },
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
          ),
          Positioned(
            left: 15,
            top: 63,
            child: Container(
              width: 35,
              height: 2,
              decoration: ShapeDecoration(
                color: textFieldBottomBorderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
        ],
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
          color: Colors.transparent,
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
