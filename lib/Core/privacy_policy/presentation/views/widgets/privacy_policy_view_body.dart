import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "In Our Application \n",
                        style: Styles.manropeMedium18.copyWith(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text:
                            "we're creating something cool!\nImagine turning your everyday commute into\na chance to help others and make some\nextra cash.\n\nLots of people travel each day with space in\ntheir cars or backpacks that they don't use.\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
