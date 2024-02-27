import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wheel_n_deal/constants.dart';

class PostreviewItem extends StatefulWidget {
  const PostreviewItem({super.key});

  @override
  State<PostreviewItem> createState() => _PostreviewItemState();
}

class _PostreviewItemState extends State<PostreviewItem> {
  String? review;
  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF191D31),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 30,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "What’s your rate?",
              style: Styles.manropeSemiBold16.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Your feedback helps us improve the delivery service!",
              style: Styles.cairoRegular.copyWith(
                color: const Color(0xFFA3A3A3),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              log(rating.toString());
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Post a comment?",
              style: Styles.manropeSemiBold16.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 135,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.50, color: Color(0xFF191D31)),
                borderRadius: BorderRadius.circular(8),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x7FFF981A),
                  blurRadius: 8,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _reviewController,
                  onChanged: (value) {
                    review = value;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF3F3F3),
                    contentPadding: const EdgeInsets.symmetric(vertical: 3),
                    hintText: 'Type your message..',
                    hintStyle: const TextStyle(color: Color(0xFFA3A3A3)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xff55433c), width: 2.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xCCA3A3A3), width: 1.0),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(AssetsData.attachment),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: SvgPicture.asset(AssetsData.emojis),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 21.13),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  AssetsData.sendMessage,
                  width: 30.87,
                  height: 30,
                  // ignore: deprecated_member_use
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {},
            splashColor: kPrimaryColor,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: Color(0x7FFF981A),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Submit',
                textAlign: TextAlign.center,
                style: Styles.manropeExtraBold18.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
