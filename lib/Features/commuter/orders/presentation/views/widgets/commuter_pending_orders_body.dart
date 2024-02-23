import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/widgets/commuter_pending_orders_item.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterPendingOrdersBody extends StatelessWidget {
  const CommuterPendingOrdersBody({super.key});

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
            style: Styles.manropeRegular16.copyWith(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        CommuterPendingOrdersItem(
          orderStatus: 'In-Progress',
          orderStatusColor: kOrderInProgressColor,
          onTap: () {
            GoRouter.of(context).push(AppRouter.kCommuterOrderDetailesView);
          },
        ),
        const SizedBox(height: 12),
        CommuterPendingOrdersItem(
          orderStatus: 'Pending',
          orderStatusColor: kOrderPendingColor,
          onTap: () {
            GoRouter.of(context).push(AppRouter.kCommuterOrderDetailesView);
          },
        ),
        const SizedBox(height: 12),
        CommuterPendingOrdersItem(
          orderStatus: 'Fail..!',
          orderStatusColor: kOrderFailColor,
          onTap: () {
            GoRouter.of(context).push(AppRouter.kCommuterOrderDetailesView);
          },
        ),
      ],
    );
  }
}
