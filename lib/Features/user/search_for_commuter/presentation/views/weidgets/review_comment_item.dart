import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class ReviewCommentItem extends StatelessWidget {
  const ReviewCommentItem({
    super.key,
    required this.review,
  });

  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 6,
        left: 19,
        right: 19,
        bottom: 8,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Color(0xFF1D272F),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
      ),
      child: Center(
        child: Text(
          review,
          style: Styles.poppinsRegular.copyWith(
            letterSpacing: -0.41,
          ),
        ),
      ),
    );
  }
}
