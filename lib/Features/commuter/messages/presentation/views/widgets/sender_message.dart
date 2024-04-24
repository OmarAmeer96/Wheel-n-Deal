import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class SenderMessage extends StatelessWidget {
  final String messageContent;
  final String formattedTime = DateFormat('h:mm a').format(DateTime.now());

  SenderMessage({super.key, required this.messageContent});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF191D31),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  messageContent,
                  style: Styles.poppinsMedium.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.done_all,
            size: 25,
            color: kPrimaryColor,
          ),
          const SizedBox(
            width: 7.77,
          ),
          Text(
            formattedTime,
            style: Styles.manropeRegular14.copyWith(fontSize: 12),
          ),
        ],
      )
    ]);
  }
}
