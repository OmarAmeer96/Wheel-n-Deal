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
      style: Styles.manropeRegular12.copyWith(
        fontSize: 16,
        color: Colors.deepOrange,
      ),
    );
  }
}
