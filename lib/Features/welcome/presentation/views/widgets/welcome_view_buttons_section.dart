import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';

class WelcomeViewButtonsSection extends StatelessWidget {
  const WelcomeViewButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}
