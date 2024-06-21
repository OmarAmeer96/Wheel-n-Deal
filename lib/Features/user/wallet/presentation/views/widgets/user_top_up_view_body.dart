import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';

import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/widgets/user_balance_item.dart';
import 'package:wheel_n_deal/constants.dart';

class UserTopUpViewBody extends StatefulWidget {
  const UserTopUpViewBody({super.key});

  @override
  State<UserTopUpViewBody> createState() => _UserTopUpViewBodyState();
}

class _UserTopUpViewBodyState extends State<UserTopUpViewBody> {
  String? dropdownValue = 'Visa';
  final List<Job> _list = [
    Job('Visa', SvgPicture.asset(AssetsData.visaIcon)),
    Job('Vodafone Cash', SvgPicture.asset(AssetsData.vodafoneCashIcon)),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const UserBalanceItem(
                isHere: false,
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tob Up Balance",
                  style: Styles.manropeSemiBold16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose a payment method to continue",
                  style: Styles.dMSansRegular.copyWith(
                    color: const Color(0xFF79859A),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomDropdown<Job>(
                hintText: 'Select payment method',
                items: _list,
                onChanged: (value) {
                  log('changing value to: $value');
                },
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  headerStyle: Styles.cairoSemiBold.copyWith(
                    color: Colors.black.withOpacity(0.7),
                  ),
                  hintStyle: Styles.cairoSemiBold.copyWith(
                    color: Colors.black.withOpacity(0.7),
                  ),
                  listItemStyle: Styles.cairoSemiBold.copyWith(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              const Spacer(),
              CustomMainButton(
                text: "Continue",
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 60,
                                height: 6,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFA3A3A3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 48,
                              ),
                              SvgPicture.asset(
                                AssetsData.successIcon,
                                height: 140,
                              ),
                              const SizedBox(
                                height: 42,
                              ),
                              Text(
                                'Top Up Successfully!',
                                style:
                                    Styles.manropeBold32.copyWith(fontSize: 26),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Congratulation! your balance already added,\nand please check your balance.',
                                textAlign: TextAlign.center,
                                style: Styles.manropeRegular15.copyWith(
                                  fontSize: 16,
                                  color: const Color(0xFFA3A3A3),
                                ),
                              ),
                              const Spacer(),
                              CustomMainButton(
                                text: "Back",
                                onPressed: () {
                                  context.pushNamed(
                                    Routes.kUserHomeView,
                                  );
                                },
                                color: kPrimaryColor,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                color: kPrimaryColor,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Job {
  final String name;
  final Widget icon;
  const Job(this.name, this.icon);

  @override
  String toString() {
    return name;
  }
}
