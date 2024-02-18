import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/constants.dart';

class ChooseCommuterButNoOrderYetViewBody extends StatelessWidget {
  const ChooseCommuterButNoOrderYetViewBody({super.key});

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
              style: Styles.manropeExtraBold32.copyWith(fontSize: 26),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              ' Go to make your order now or\nchoose from your pending orders\nfor the commuter to pock .',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomMainButton(
                    text: 'Make order',
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kUserPostOrderView);
                    },
                    color: kPrimaryColor,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomMainButton(
                    text: 'Choose from pending orders',
                    textColor: Colors.black,
                    borderSideColor: Colors.black,
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kUserOrdersView);
                    },
                    color: const Color(0xFFF3F3F3),
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
