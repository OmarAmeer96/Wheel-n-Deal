import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class SuccessfulRegisterViewBody extends StatelessWidget {
  const SuccessfulRegisterViewBody({super.key});

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
              'Register Successfully',
              style: Styles.manropeExtraBold32.copyWith(fontSize: 26),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Congratulation! your account successfully\ncreated.',
              textAlign: TextAlign.center,
              style: Styles.manropeRegular15.copyWith(
                fontSize: 16,
                color: const Color(0xFFA3A3A3),
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            Text(
              'Continue As',
              style: Styles.manropeExtraBold32.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 29,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomMainButton(
                  width: Responsive.screenWidth(context) * 0.37,
                  text: 'User',
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kUserHomeView);
                  },
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  width: 40,
                ),
                CustomMainButton(
                  width: Responsive.screenWidth(context) * 0.37,
                  text: 'Commuter',
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kCommuterHomeView);
                  },
                  color: kPrimaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
