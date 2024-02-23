import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/widgets/commuter_pick_order_view_body.dart';

class CommuterPickOrderView extends StatelessWidget {
  const CommuterPickOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommuterPickOrderViewBody(
        isAppBarIconNotHidden: true,
        onTap: () {
          GoRouter.of(context).pop();
        },
      ),
    );
  }
}
