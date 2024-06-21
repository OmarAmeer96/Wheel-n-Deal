import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterStartedDeliveryViewBody extends StatelessWidget {
  const CommuterStartedDeliveryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsData.successIcon,
                height: 140,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                textAlign: TextAlign.center,
                "Delivery Started",
                style: Styles.manropeBold32.copyWith(fontSize: 26),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'The customer will know that the trip has begun and will track it.',
                textAlign: TextAlign.center,
                style: Styles.manropeRegular15.copyWith(
                  fontSize: 18,
                  color: const Color(0xFFA3A3A3),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomMainButton(
                text: "Back to Home",
                onPressed: () {
                  context.pushNamed(Routes.kCommuterHomeView);
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
