import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/widgets/user_top_up_view_body.dart';

class UserTopUpView extends StatelessWidget {
  const UserTopUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Top Up",
        textStyle: Styles.manropeRegular16.copyWith(
          fontSize: 18,
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const UserTopUpViewBody(),
    );
  }
}
