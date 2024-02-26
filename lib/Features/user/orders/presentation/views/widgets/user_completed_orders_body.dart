import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_completed_orders_item.dart';

class UserCompletedOrdersBody extends StatelessWidget {
  const UserCompletedOrdersBody({super.key});

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
            "Recent Deliveries",
            style: Styles.manropeSemiBold16.copyWith(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        UserCompletedOrdersItem(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kUserCompletedOrderDetailsView);
          },
        ),
      ],
    );
  }
}
