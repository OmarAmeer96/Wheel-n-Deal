import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/notifications_item.dart';

class CommuterNotificationsViewBody extends StatelessWidget {
  const CommuterNotificationsViewBody({super.key});

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
            NotificationItem(
              icon: AssetsData.commuterChoosedOrderIcon,
              text1: 'Someone choose you to deliver the order',
              text2: 'Tap to confirm the order',
              time: '2m ago',
              onTap: () {
                GoRouter.of(context).push(AppRouter.kCommuterConfirmOrder1View);
              },
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
              text2: 'Tap to confirm the order and view the commuter',
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
