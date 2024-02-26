import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

import '../../../../../../Core/widgets/post_pick_orders_button.dart';

class UserPostOrderItem extends StatelessWidget {
  const UserPostOrderItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.screenWidth(context),
      height: 100,
      decoration: ShapeDecoration(
        color: const Color(0xFF1D272F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Post a new order',
                  style: Styles.manropeSemiBold16.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                PostPickOrdersButton(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kUserPostOrderView);
                  },
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "We will get you what you need from anywhere",
                style: Styles.dMSansRegular,
              ),
            )
          ],
        ),
      ),
    );
  }
}
