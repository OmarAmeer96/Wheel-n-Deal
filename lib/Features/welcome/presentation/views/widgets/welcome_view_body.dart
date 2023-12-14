import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Features/welcome/presentation/views/widgets/welcome_view_buttons_section.dart';

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
          const WelcomeViewButtonsSection(),
        ],
      ),
    );
  }
}
