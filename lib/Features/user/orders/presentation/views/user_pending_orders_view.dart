import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_pending_orders_view_body.dart';

class UserPendingOrdersView extends StatelessWidget {
  const UserPendingOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Orders",
        onPressed: () {},
      ),
      body: const UserPendingOrdersViewBody(),
    );
  }
}
