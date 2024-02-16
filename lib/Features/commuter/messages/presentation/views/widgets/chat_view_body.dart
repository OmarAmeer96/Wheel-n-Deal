import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/chat_app_bar.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/receiver_message.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/sender_message.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  String? search;

  final _messageController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15, right: 16.0, top: 10, bottom: 20),
            child: Column(
              children: [
                const ChatAppBar(),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  width: 100,
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Yesterday',
                        textAlign: TextAlign.center,
                        style: Styles.cairoRegular.copyWith(
                          color: const Color(0xFF191D31),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SenderMessage(messageContent: 'When will you deliver my order'),
                const SizedBox(
                  height: 15,
                ),
                ReceiverMessage(
                    messageContent:
                        ' I’m on the way to your home, Please\nwait a moment. Thanks!'),
                const SizedBox(
                  height: 15,
                ),
                SenderMessage(messageContent: 'Thanks'),
                const SizedBox(
                  height: 15,
                ),
                ReceiverMessage(messageContent: "Welcome"),
                TextFormField(
                  controller: _messageController,
                  onChanged: (value) {},
                  enabled: true,
                  style: Styles.poppinsSemiBold16.copyWith(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF3F3F3),
                    contentPadding: const EdgeInsets.symmetric(vertical: 3),
                    constraints: const BoxConstraints(
                      // maxHeight: 80,
                      minHeight: 60,
                      maxWidth: double.infinity,
                      minWidth: double.infinity,
                    ),
                    hintText: "Type your message",
                    hintStyle: Styles.cairoRegular
                        .copyWith(color: const Color(0xFFA3A3A3)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(0xff55433c), width: 2.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xCCA3A3A3), width: 1.0),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: InkWell(
                          onTap: () {},
                          child: const Icon(Icons.attach_file_outlined)),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Icon(Icons.emoji_emotions),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}