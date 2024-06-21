import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';

import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_orders_view_body.dart';

class UserOrdersView extends StatelessWidget {
  const UserOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Orders",
        onPressed: () {
          context.pop();
        },
      ),
      body: const UserOrdersViewBody(),
    );
  }
}
