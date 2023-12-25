import 'package:flutter/widgets.dart';
import 'package:wheel_n_deal/Core/widgets/orders_stats_buttons.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/widgets/commuter_completed_orders_body.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/widgets/commuter_pending_orders_body.dart';

class CommuterOrdersViewBody extends StatefulWidget {
  const CommuterOrdersViewBody({super.key});

  @override
  CommuterOrdersViewBodyState createState() => CommuterOrdersViewBodyState();
}

class CommuterOrdersViewBodyState extends State<CommuterOrdersViewBody> {
  bool _isPending = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OrdersStatsButtons(
              isPending: _isPending,
              onPendingPressed: () {
                setState(() {
                  _isPending = true;
                });
              },
              onCompletedPressed: () {
                setState(() {
                  _isPending = false;
                });
              },
            ),
            _isPending
                ? const CommuterPendingOrdersBody()
                : const CommuterCompletedOrdersBody(),
          ],
        ),
      ),
    );
  }
}
