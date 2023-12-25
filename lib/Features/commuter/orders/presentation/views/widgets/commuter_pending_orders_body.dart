import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/widgets/commuter_pending_orders_item.dart';

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
        const CommuterPendingOrdersItem(),
      ],
    );
  }
}
