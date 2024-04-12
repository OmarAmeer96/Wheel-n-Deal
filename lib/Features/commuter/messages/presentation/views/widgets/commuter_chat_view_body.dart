import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/chat_app_bar.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/receiver_message.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/sender_message.dart';

class CommuterChatViewBody extends StatefulWidget {
  const CommuterChatViewBody({super.key});

  @override
  State<CommuterChatViewBody> createState() => _CommuterChatViewBodyState();
}

class _CommuterChatViewBodyState extends State<CommuterChatViewBody> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    // ignore: unused_local_variable
    String? message;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 16.0, top: 5),
                  child: Column(
                    children: [
                      const ChatAppBar(),
                      const SizedBox(height: 11),
                      Container(
                        width: 100,
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF3F3F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Yesterday',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF191D31),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 15),
                            SenderMessage(
                              messageContent: 'When will you deliver my order',
                            ),
                            const SizedBox(height: 15),
                            ReceiverMessage(
                              messageContent:
                                  'I’m on the way to your home, Please\nwait a moment. Thanks!',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 17.0, right: 17, bottom: 17),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                onChanged: (value) {
                                  message = value;
                                },
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF3F3F3),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  hintText: 'Type your message..',
                                  hintStyle:
                                      const TextStyle(color: Color(0xFFA3A3A3)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xff55433c), width: 2.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color(0xCCA3A3A3), width: 1.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: InkWell(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                          AssetsData.attachment),
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child:
                                          SvgPicture.asset(AssetsData.emojis),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 21.13),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                AssetsData.sendMessage,
                                width: 30.87,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
