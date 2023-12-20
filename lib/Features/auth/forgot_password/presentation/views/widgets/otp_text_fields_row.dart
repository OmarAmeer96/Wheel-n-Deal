import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/widgets/otp_text_fields_row_item.dart';

class OtpTextFieldsRow extends StatelessWidget {
  const OtpTextFieldsRow({super.key});

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
        ),
        OtpTextFieldsRowItem(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
        OtpTextFieldsRowItem(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
        OtpTextFieldsRowItem(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ],
    );
  }
}
