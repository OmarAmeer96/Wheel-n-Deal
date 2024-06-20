import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/widgets/selected_by_item.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/widgets/show_decline_order_confirmation_dialog.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterConfirmOrder1ViewBody extends StatelessWidget {
  const CommuterConfirmOrder1ViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 26),
                          Text(
                            "You have been selected by",
                            style:
                                Styles.manropeSemiBold16.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 45),
                          const SelectedByItem(
                            name: 'Ahmed',
                            phoneNumber: '01554111002',
                          ),
                          const SizedBox(height: 31),
                          Text(
                            "See order details and choose to accept it or not.",
                            style:
                                Styles.manropeRegular14.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 335),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: Responsive.screenWidth(context) * 0.85,
                    child: CustomMainButton(
                      text: 'Show Order Details',
                      color: kPrimaryColor,
                      onPressed: () {
                        GoRouter.of(context)
                            .push(AppRouter.kCommuterPickOrderDetailsView);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: Responsive.screenWidth(context) * 0.85,
                    child: CustomMainButton(
                      borderSideColor: Colors.black,
                      text: 'Decline The Order',
                      textColor: const Color(0xFF1D272F),
                      color: const Color(0xfff3f3f3),
                      onPressed: () {
                        showDeclineOrderConfirmationDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
