import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CustomReviewSummaryValueText extends StatelessWidget {
  const CustomReviewSummaryValueText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: Styles.manropeSemiBold12.copyWith(
        fontSize: 16,
        color: Colors.deepOrange,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
