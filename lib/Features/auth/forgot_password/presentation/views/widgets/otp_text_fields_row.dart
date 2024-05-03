import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/widgets/otp_text_fields_row_item.dart';

class OtpTextFieldsRow extends StatelessWidget {
  final TextEditingController otpController1;
  final TextEditingController otpController2;
  final TextEditingController otpController3;
  final TextEditingController otpController4;

  const OtpTextFieldsRow({
    super.key,
    required this.otpController1,
    required this.otpController2,
    required this.otpController3,
    required this.otpController4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OtpTextFieldsRowItem(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          otpController: otpController1,
        ),
        OtpTextFieldsRowItem(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          otpController: otpController2,
        ),
        OtpTextFieldsRowItem(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          otpController: otpController3,
        ),
        OtpTextFieldsRowItem(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          otpController: otpController4,
        ),
      ],
    );
  }
}
