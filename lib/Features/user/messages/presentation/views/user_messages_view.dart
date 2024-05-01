import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/messages/presentation/views/widgets/user_messages_view_body.dart';

class UserMessagesView extends StatelessWidget {
  const UserMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Messages",
        textStyle: Styles.manropeSemiBold16,
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const UserMessagesViewBody(),
    );
  }
}