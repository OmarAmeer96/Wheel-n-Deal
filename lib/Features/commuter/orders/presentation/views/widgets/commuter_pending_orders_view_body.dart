import 'package:flutter/widgets.dart';
import 'package:wheel_n_deal/Core/widgets/orders_stats_buttons.dart';

class CommuterPendingOrdersViewBody extends StatelessWidget {
  const CommuterPendingOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OrdersStatsButtons(
            widget1: Center(
              child: Text("Hello, this is pending"),
            ),
            widget2: Center(
              child: Text("Hello, this is completed"),
            ),
          ),
        ],
      ),
    );
  }
}
