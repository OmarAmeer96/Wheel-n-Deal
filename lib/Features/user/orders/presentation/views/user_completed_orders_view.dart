import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_completed_orders_view_body.dart';

class UserCompletedOrdersView extends StatelessWidget {
  const UserCompletedOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserCompletedOrdersViewBody(),
    );
  }
}
