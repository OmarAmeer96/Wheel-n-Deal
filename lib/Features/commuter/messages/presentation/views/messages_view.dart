import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/messages_view_body.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Messages",
        textStyle: Styles.manropeRegular16,
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const MessagesViewBody(),
    );
  }
}
