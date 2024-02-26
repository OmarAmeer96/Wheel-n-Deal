import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class ReceiverMessage extends StatelessWidget {
  final String messageContent;
  final String formattedTime = DateFormat('h:mm a').format(DateTime.now());

  ReceiverMessage({super.key, required this.messageContent});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              border: Border.all(
                color: const Color(
                    0xFFA3A3A3), // Choose your desired border color here
                width: 1, // Specify the width of the border
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  messageContent,
                  maxLines: 3,
                  style: Styles.manropeRegular14
                      .copyWith(color: const Color(0xFF6F6F6F)),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
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
