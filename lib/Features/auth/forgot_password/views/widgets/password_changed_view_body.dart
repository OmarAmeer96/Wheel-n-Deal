import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class PasswordChangedViewBody extends StatelessWidget {
  const PasswordChangedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              CustomMainButton(
                text: 'Back to login',
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kLoginView);
                },
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
