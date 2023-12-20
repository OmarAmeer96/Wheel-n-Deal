import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/notifications_item.dart';

class UserNotificationsViewBody extends StatelessWidget {
  const UserNotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 26,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Recent",
              style: Styles.manropeRegular16.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          const Divider(
            color: Color(0xFFF3F3F3),
            thickness: 2,
          ),
          const SizedBox(
            height: 5,
          ),
          const NotificationItem(
            icon: AssetsData.notifOrders,
            text1: 'Your order already delivered',
            text2: 'enjoy!',
            time: '2m ago',
          ),
          const SizedBox(
            height: 5,
          ),
          const NotificationItem(
            icon: AssetsData.notifOrders,
            text1: 'Your order already delivered',
            text2: 'enjoy!',
            time: '2m ago',
          ),
          const SizedBox(
            height: 5,
          ),
          const NotificationItem(
            icon: AssetsData.notifOrders,
            text1: 'Your order already delivered',
            text2: 'enjoy!',
            time: '2m ago',
          ),
          const SizedBox(
            height: 5,
          ),
          const NotificationItem(
            icon: AssetsData.notifOrders,
            text1: 'Your order already delivered',
            text2: 'enjoy!',
            time: '2m ago',
          ),
          const SizedBox(
            height: 5,
          ),
          const NotificationItem(
            icon: AssetsData.notifOrders,
            text1: 'Your order already delivered',
            text2: 'enjoy!',
            time: '2m ago',
          ),
          const SizedBox(
            height: 5,
          ),
          const NotificationItem(
            icon: AssetsData.notifOrders,
            text1: 'Your order already delivered',
            text2: 'enjoy!',
            time: '2m ago',
          ),
          const SizedBox(
            height: 5,
          ),
          const NotificationItem(
            icon: AssetsData.notifOrders,
            text1: 'Your order already delivered',
            text2: 'enjoy!',
            time: '2m ago',
          ),
        ],
      ),
    );
  }
}
