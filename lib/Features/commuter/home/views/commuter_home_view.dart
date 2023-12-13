import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Features/commuter/home/views/widgets/commuter_home_view_body.dart';

class CommuterHomeView extends StatelessWidget {
  const CommuterHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const CommuterHomeViewBody(),
    );
  }
}
