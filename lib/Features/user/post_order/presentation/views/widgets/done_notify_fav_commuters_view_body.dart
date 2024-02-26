import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/constants.dart';

class DoneNotifyFavCommutersViewBody extends StatelessWidget {
  const DoneNotifyFavCommutersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsData.successIcon,
              height: 140,
            ),
            const SizedBox(
              height: 42,
            ),
            Text(
              'Done!',
              style: Styles.manropeBold32.copyWith(fontSize: 26),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'We will send you a notification\nwhen commuter pick your order.',
              textAlign: TextAlign.center,
              style: Styles.manropeRegular15.copyWith(
                fontSize: 18,
                color: const Color(0xFFA3A3A3),
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomMainButton(
                text: 'Back to Home',
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kUserHomeView);
                },
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
