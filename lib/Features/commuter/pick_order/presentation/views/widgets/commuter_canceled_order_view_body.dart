import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterCanceledOrderViewBody extends StatelessWidget {
  const CommuterCanceledOrderViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsData.successIcon,
                height: 140,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Order Canceled",
                style: Styles.manropeBold32.copyWith(fontSize: 26),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomMainButton(
                text: "Back to Home",
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kCommuterHomeView);
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
