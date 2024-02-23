import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_canceled_order_view_body.dart';

class UserCanceledOrderView extends StatelessWidget {
  const UserCanceledOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserCanceledOrderViewBody(),
    );
  }
}
