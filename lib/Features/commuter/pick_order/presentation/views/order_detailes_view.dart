import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/widgets/order_detailes_view_body.dart';

class OrderDetailesView extends StatelessWidget {
  const OrderDetailesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "About Wheel N’ Deal",
        textStyle: Styles.manropeRegular16.copyWith(
          fontSize: 18,
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const OrderDetailesViewBody(),
    );
  }
}
