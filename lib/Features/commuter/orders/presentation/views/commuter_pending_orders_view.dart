import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/widgets/commuter_pending_orders_view_body.dart';

class CommuterPendingOrdersView extends StatelessWidget {
  const CommuterPendingOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Orders",
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const CommuterPendingOrdersViewBody(),
    );
  }
}
