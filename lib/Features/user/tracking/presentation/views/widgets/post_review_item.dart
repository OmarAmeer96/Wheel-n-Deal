import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class PostreviewItem extends StatelessWidget {
  const PostreviewItem({super.key});

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
                fontSize: 16,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Your feedback helps us improve the delivery service!",
              style: Styles.cairoRegular.copyWith(
                color: const Color(0xFFA3A3A3),
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          
        ],
      ),
    );
  }
}
