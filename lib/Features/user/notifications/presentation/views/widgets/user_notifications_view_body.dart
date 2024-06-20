import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/notifications_item.dart';

class UserNotificationsViewBody extends StatelessWidget {
  const UserNotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
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
                style: Styles.manropeSemiBold16.copyWith(fontSize: 18),
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
            NotificationItem(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kUserTrackOrderView);
              },
              icon: AssetsData.locationIcon,
              text1: 'Your order in the way now',
              text2: 'Tap to view the tracking.',
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
              text2:
                  'Tap to confirm the order and view the commuter chiecheiuhcieh',
              time: '2m ago',
            ),
            const SizedBox(
              height: 5,
            ),
            const NotificationItem(
              icon: AssetsData.notifOrders,
              text1: 'Your order already delivered',
              text2:
                  'Tap to confirm the order and view the commuter a;cmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm;slcm;alsmc;lam;clm; kcnapcpsmmmmmmmmmmmmmmmmpoapcoaspcomapsmocpoampcomapscmpasompcomapsomcpaoscmmcpsompcomaspoc',
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
      ),
    );
  }
}
