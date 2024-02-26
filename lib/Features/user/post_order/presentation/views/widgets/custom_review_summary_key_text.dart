import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CustomReviewSummaryKeyText extends StatelessWidget {
  const CustomReviewSummaryKeyText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Styles.manropeBold32.copyWith(fontSize: 15),
    );
  }
}
