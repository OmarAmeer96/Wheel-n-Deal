import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/widgets/customer_accept_order_details_view_body.dart';

class CustomerAcceptOrderDetailsView extends StatelessWidget {
  const CustomerAcceptOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Confirm The Order",
        textStyle: Styles.manropeSemiBold16,
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const CustomerAcceptOrderDetailsViewBody(),
    );
  }
}
