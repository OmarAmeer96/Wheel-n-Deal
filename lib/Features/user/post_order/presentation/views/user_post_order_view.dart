import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/user_post_order_view_body.dart';

class UserPostOrderView extends StatelessWidget {
  const UserPostOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Make Order",
        textStyle: Styles.manropeSemiBold16.copyWith(
          fontSize: 18,
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const UserPostOrderViewBody(),
    );
  }
}
