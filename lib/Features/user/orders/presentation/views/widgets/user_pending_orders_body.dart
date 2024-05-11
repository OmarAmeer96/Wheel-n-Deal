import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_pending_orders_item.dart';

class UserPendingOrdersBody extends StatelessWidget {
  const UserPendingOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 26,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Recent Packages",
            style: Styles.manropeSemiBold16.copyWith(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        UserPendingOrdersItem(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kUserOrderDetailsView);
          },
        ),
        SizedBox(
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "عموره لسه هيظبطها 😊",
                  style: Styles.manropeRegular15.copyWith(
                    fontSize: 30,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
