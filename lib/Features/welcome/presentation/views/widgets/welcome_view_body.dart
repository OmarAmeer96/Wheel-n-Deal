import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';

import '../../../../../Core/utils/app_router.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: Responsive.screenHeight(context) * 0.06,
          ),
          Image.asset(AssetsData.welcomeLogo2),
          const Expanded(
            child: SizedBox(
              height: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomMainButton(
              text: "Login",
              color: const Color(0xffFF981A),
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kLoginView);
              },
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomMainButton(
              text: "Register",
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kRegisterView);
              },
              color: const Color(0xffF3F3F3),
              textColor: const Color(0xff1D272F),
              borderSideColor: const Color(0xff1D272F),
            ),
          ),
          SizedBox(
            height: Responsive.screenHeight(context) * 0.2,
          ),
        ],
      ),
    );
  }
}
