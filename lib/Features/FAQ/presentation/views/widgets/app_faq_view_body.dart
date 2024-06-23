import 'package:flutter/material.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class AppFaqViewBody extends StatelessWidget {
  const AppFaqViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Scrollbar(
        thumbVisibility: true,
        interactive: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              EasyFaq(
                question: "What is Wheel N' Deal Application?",
                answer:
                    "It is an on-demand delivery service that allows Egyptians to send and receive packages – all delivered by Wheel N' Deal riders.",
                questionTextStyle: Styles.manropeBold32.copyWith(
                  fontSize: 18,
                ),
                anserTextStyle: Styles.manropeRegular15.copyWith(
                  fontSize: 15,
                ),
                collapsedIcon: SvgPicture.asset(AssetsData.addIcon),
                expandedIcon: SvgPicture.asset(AssetsData.removeIcon),
                duration: const Duration(milliseconds: 400),
              ),
              const SizedBox(
                height: 25,
              ),
              EasyFaq(
                question: "Submit a delivery request",
                answer:
                    "Enter the delivery location in the Make an order box for your Wheal N' Deal app and choose one of the commuters or post it publicy.",
                questionTextStyle: Styles.manropeBold32.copyWith(
                  fontSize: 18,
                ),
                anserTextStyle: Styles.manropeRegular15.copyWith(
                  fontSize: 15,
                ),
                collapsedIcon: SvgPicture.asset(AssetsData.addIcon),
                expandedIcon: SvgPicture.asset(AssetsData.removeIcon),
                duration: const Duration(milliseconds: 400),
              ),
              const SizedBox(
                height: 25,
              ),
              EasyFaq(
                question: "In-app payment",
                answer:
                    "Once the commuter has agreed to deliver your order, the delivery fee will be charged using your preferred payment method in the app.",
                questionTextStyle: Styles.manropeBold32.copyWith(
                  fontSize: 18,
                ),
                anserTextStyle: Styles.manropeRegular15.copyWith(
                  fontSize: 15,
                ),
                collapsedIcon: SvgPicture.asset(AssetsData.addIcon),
                expandedIcon: SvgPicture.asset(AssetsData.removeIcon),
                duration: const Duration(milliseconds: 400),
              ),
              const SizedBox(
                height: 25,
              ),
              EasyFaq(
                question: "Tips while using Wheel N’ Deal Delivery",
                answer:
                    "Prepare your parcels for delivery\nWhat can I send? There are restrictions when using this service in terms of number of pieces, weight, size and items.\n\nMaximum number of items 6 (bags/boxes)\n\nMaximum weight 20kg per piece\n\nMaximum item size: 60 x 60 x 60 cm\n\nNo prohibited materials may be delivered using this service.",
                questionTextStyle: Styles.manropeBold32.copyWith(
                  fontSize: 18,
                ),
                anserTextStyle: Styles.manropeRegular15.copyWith(
                  fontSize: 15,
                ),
                collapsedIcon: SvgPicture.asset(AssetsData.addIcon),
                expandedIcon: SvgPicture.asset(AssetsData.removeIcon),
                duration: const Duration(milliseconds: 400),
              ),
              const SizedBox(
                height: 25,
              ),
              EasyFaq(
                question: "Is my parcel insured during delivery?",
                answer:
                    "Wheel N' Deal Delivery does not provide any insurance nor does it take any responsibility for the goods sent using this service. Please exercise your own judgment before sending items as you will be using the Delivery Services at your own risk.",
                questionTextStyle: Styles.manropeBold32.copyWith(
                  fontSize: 18,
                ),
                anserTextStyle: Styles.manropeRegular15.copyWith(
                  fontSize: 15,
                ),
                collapsedIcon: SvgPicture.asset(AssetsData.addIcon),
                expandedIcon: SvgPicture.asset(AssetsData.removeIcon),
                duration: const Duration(milliseconds: 400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
