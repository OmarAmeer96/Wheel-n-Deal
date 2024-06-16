import 'package:flutter/widgets.dart';
import 'package:wheel_n_deal/Core/widgets/orders_stats_buttons.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_completed_orders_body.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_pending_orders_body.dart';

class UserOrdersViewBody extends StatefulWidget {
  const UserOrdersViewBody({super.key});

  @override
  CommuterOrdersViewBodyState createState() => CommuterOrdersViewBodyState();
}

class CommuterOrdersViewBodyState extends State<UserOrdersViewBody> {
  bool _isPending = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
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
                ?  const UserPendingOrdersBody()
                : const UserCompletedOrdersBody(),
          ],
        ),
      ),
    );
  }
}
