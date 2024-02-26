import 'package:flutter/material.dart';
import 'package:wheel_n_deal/constants.dart';

class RatingItem extends StatelessWidget {
  final int rating;
  final Color starColor;
  final Color unselectedColor;

  const RatingItem({
    super.key,
    required this.rating,
    this.starColor = kPrimaryColor,
    this.unselectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_outline,
          size: 30,
          color: index < rating ? starColor : unselectedColor,
        ),
      ),
    );
  }
}
