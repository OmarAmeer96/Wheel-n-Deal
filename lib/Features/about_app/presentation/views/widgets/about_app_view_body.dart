import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class AboutAppViewBody extends StatelessWidget {
  const AboutAppViewBody({super.key});

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
                        style: Styles.manropeExtraBold18.copyWith(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text:
                            "we're creating something cool!\nImagine turning your everyday commute into\na chance to help others and make some\nextra cash.\n\nLots of people travel each day with space in\ntheir cars or backpacks that they don't use.\n\n",
                        style: Styles.manropeExtraBold18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Our Solution? \n",
                        style: Styles.manropeExtraBold18.copyWith(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text:
                            "A user-friendly platform that lets commuters offer to deliver packages during their regular travels without any extra hassle.\n\nWe're tapping into the power of shared resources and community collaboration. Our platform connects people who need packages delivered with those who are already headed in the right direction. It's a win-win; senders get their packages delivered conveniently, and commuters can earn a little extra by helping out.\n\n",
                        style: Styles.manropeExtraBold18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Wheel N' Deal Application \n",
                        style: Styles.manropeExtraBold18.copyWith(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Is characterized by ease and simplicity in its design and development.\n\n",
                        style: Styles.manropeExtraBold18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Our Focus On \n",
                        style: Styles.manropeExtraBold18.copyWith(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text:
                            "making it easy, safe, and efficient. We've got a simple interface, strong security measures, and a smart matching system to connect senders with available commuters.\nBy doing this, we aim to meet the rising demand for eco-friendly, cost-effective, and community-driven delivery solutions.\n\n",
                        style: Styles.manropeExtraBold18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text:
                            "This abstract gives you a quick look at our exciting Application.\n",
                        style: Styles.manropeExtraBold18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "As you use this application, you'll discover how we're making this innovative idea a reality.\nWheel 🤔? Then Deal 🤝.\n",
                        style: Styles.manropeExtraBold18.copyWith(
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
