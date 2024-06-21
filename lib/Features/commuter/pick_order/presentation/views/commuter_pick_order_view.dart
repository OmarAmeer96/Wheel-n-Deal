import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/widgets/commuter_pick_order_view_body.dart';

class CommuterPickOrderView extends StatelessWidget {
  const CommuterPickOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommuterPickOrderViewBody(
        isAppBarIconNotHidden: true,
        onTap: () {
          context.pop();
        },
      ),
    );
  }
}
