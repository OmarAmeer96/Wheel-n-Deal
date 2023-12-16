import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Features/user/home/views/widgets/user_home_view_body.dart';

import '../../../../Core/utils/styles.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Profile",
        textStyle: Styles.manropeRegular16,
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const UserHomeViewBody(),
    );
  }
}
