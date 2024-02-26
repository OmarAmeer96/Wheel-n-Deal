import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/constants.dart';

class TripDeletedViewBody extends StatelessWidget {
  const TripDeletedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsData.successIcon,
                height: 140,
              ),
              const SizedBox(
                height: 29,
              ),
              Text(
                'Trip Deleted',
                style: Styles.manropeBold32.copyWith(fontSize: 26),
              ),
              const SizedBox(
                height: 88,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomMainButton(
                  text: 'Back to Home',
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kCommuterHomeView);
                  },
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
