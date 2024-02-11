import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/widgets/commuter_confirm_order_1_view_body.dart';

class CommuterConfirmOrder1View extends StatelessWidget {
  const CommuterConfirmOrder1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: 'Confirm Order',
        textStyle: Styles.manropeRegular16.copyWith(
          fontSize: 18,
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const CommuterConfirmOrder1ViewBody(),
    );
  }
}
