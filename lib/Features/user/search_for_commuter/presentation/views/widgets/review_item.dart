import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/widgets/rating_item.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/widgets/review_comment_item.dart';
import 'package:wheel_n_deal/constants.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.review,
  });

  final String image;
  final String name;
  final int rating;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xfff3f3f3),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.8,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  image,
                  width: 45,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  name,
                  style: Styles.cairoSemiBold.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: Responsive.screenWidth(context) * 0.37,
              child: RatingItem(rating: rating),
            ),
            const SizedBox(
              height: 10,
            ),
            ReviewCommentItem(review: review),
          ],
        ),
      ),
    );
  }
}
