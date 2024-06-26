import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_key_text.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_value_text.dart';

class CustomReviewSummaryItem extends StatelessWidget {
  const CustomReviewSummaryItem({
    super.key,
    required this.keyText,
    required this.valText,
  });

  final String keyText;
  final String valText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomReviewSummaryKeyText(
          text: '$keyText: ',
        ),
        Expanded(
          child: CustomReviewSummaryValueText(
            text: valText,
          ),
        ),
      ],
    );
  }
}
