import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class UserBalanceItem extends StatelessWidget {
  const UserBalanceItem({
    super.key,
    required this.isHere,
  });

  final bool isHere;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.screenWidth(context),
      height: 85,
      decoration: ShapeDecoration(
        color: const Color(0xFF1D272F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          bottom: 16,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Balance",
                  style: Styles.manropeRegular14.copyWith(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
                Text(
                  "\$0",
                  style: Styles.cairoSemiBold.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "Top Up",
              style: Styles.manropeRegular14.copyWith(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                isHere
                    ? GoRouter.of(context).push(AppRouter.kUserTopUpView)
                    : null;
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
