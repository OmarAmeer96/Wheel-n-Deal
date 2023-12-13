import 'package:flutter/material.dart';

class PasswordChangedViewBody extends StatelessWidget {
  const PasswordChangedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsData.checkStarPng,
              height: 110,
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
    );
  }
}
