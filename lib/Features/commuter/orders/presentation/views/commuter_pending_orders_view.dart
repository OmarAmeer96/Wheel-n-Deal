import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/widgets/commuter_pending_orders_view_body.dart';

class CommuterPendingOrdersView extends StatelessWidget {
  const CommuterPendingOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CommuterPendingOrdersViewBody(),
    );
  }
}
