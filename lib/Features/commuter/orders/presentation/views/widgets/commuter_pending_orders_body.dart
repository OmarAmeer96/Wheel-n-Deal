import 'package:flutter/material.dart';
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
        const CommuterPendingOrdersItem(
          orderStatus: 'In-Progress',
          orderStatusColor: kOrderInProgressColor,
        ),
        const SizedBox(height: 12),
        const CommuterPendingOrdersItem(
            orderStatus: 'Pending', orderStatusColor: kOrderPendingColor),
        const SizedBox(height: 12),
        const CommuterPendingOrdersItem(
          orderStatus: 'Fail..!',
          orderStatusColor: kOrderFailColor,
        ),
      ],
    );
  }
}
