import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/widgets/commuter_completed_orders_view_body.dart';

class CommuterCompletedOrdersView extends StatelessWidget {
  const CommuterCompletedOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CommuterCompletedOrdersViewBody(),
    );
  }
}
