import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/messages/presentation/views/widgets/user_messages_view_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserMessagesViewBody(),
    );
  }
}
