import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/commuter_pending_orders_view_body.dart';

class UserPendingOrdersView extends StatelessWidget {
  const UserPendingOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserPendingOrdersViewBody(),
    );
  }
}
