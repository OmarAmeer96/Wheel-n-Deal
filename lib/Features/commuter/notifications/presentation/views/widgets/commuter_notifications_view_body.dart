import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
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
            NotificationItem(
              icon: AssetsData.commuterChoosedOrderIcon,
              text1: 'Someone choose you to deliver the order',
              text2: 'Tap to confirm the order',
              time: '2 m ago',
              onTap: () {
                GoRouter.of(context).push(AppRouter.kCommuterConfirmOrder1View);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            NotificationItem(
              icon: AssetsData.notifOrders,
              text1: 'Order delivery has been confirmed',
              text2: 'Check your wallet to see your profit',
              time: '2 m ago',
              onTap: () {
                GoRouter.of(context).push(AppRouter.kCommuterWalletView);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            NotificationItem(
              icon: AssetsData.messageNotification,
              text1: 'Ahmed sent you a message',
              text2: 'Tap to see the message',
              time: '5 m ago',
              onTap: () {
                GoRouter.of(context).push(AppRouter.kCommuterChatView);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            NotificationItem(
              icon: AssetsData.orderCancelled,
              text1: 'Order cancelled',
              text2: 'Customer canceled order. tap to view',
              time: '7 m ago',
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.kCommuterCompletedOrderDetailsView);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            NotificationItem(
              icon: AssetsData.emojis,
              text1: 'Customer accepted your offer',
              text2: 'Tap to see the order , and deliver it',
              time: '10 m ago',
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.kCustomerAcceptOrderDetailsView);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            NotificationItem(
              icon: AssetsData.hint,
              text1: 'Hint!',
              text2:
                  'You should scan when you take the order , and when you deliver it',
              time: '10 m ago',
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.kCustomerAcceptOrderDetailsView);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            NotificationItem(
              icon: AssetsData.orderCancelled,
              text1: 'Order delivery failed',
              text2: '',
              time: '16 m ago',
              onTap: () {
                GoRouter.of(context).push(AppRouter.kCommuterWalletView);
              },
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
