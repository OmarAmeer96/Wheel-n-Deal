import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.titleText = "",
  });

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 26,
            ),
          ),
          Text(titleText),
        ],
      ),
    );
  }
}
