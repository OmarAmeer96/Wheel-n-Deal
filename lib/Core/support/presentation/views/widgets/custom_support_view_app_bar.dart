import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CustomSupportViewAppBar extends StatelessWidget {
  const CustomSupportViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 26,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          SizedBox(
            height: 46,
            child: Image.asset(
              AssetsData.profileImage,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Customer Service",
              style: Styles.manropeRegular16.copyWith(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
