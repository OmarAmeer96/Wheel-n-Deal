import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/commuter_chat_view_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CommuterChatViewBody(),
    );
  }
}
