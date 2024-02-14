import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/step_one_content.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/step_three_content.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/step_two_content.dart';

class UserPostOrderViewBody extends StatefulWidget {
  const UserPostOrderViewBody({super.key});

  @override
  State<UserPostOrderViewBody> createState() => _UserPostOrderViewBodyState();
}

class _UserPostOrderViewBodyState extends State<UserPostOrderViewBody> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: const MaterialColor(
              0xFFFF981A,
              {
                50: Color(0xFFFF981A),
                100: Color(0xFFFF981A),
                200: Color(0xFFFF981A),
                300: Color(0xFFFF981A),
                400: Color(0xFFFF981A),
                500: Color(0xFFFF981A),
                600: Color(0xFFFF981A),
                700: Color(0xFFFF981A),
                800: Color(0xFFFF981A),
                900: Color(0xFFFF981A),
              },
            ),
          ),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              log("Completed");
            } else {
              setState(() {
                currentStep++;
              });
            }
          },
          onStepCancel: () {
            currentStep == 0
                ? null
                : setState(() {
                    currentStep--;
                  });
          },
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Text("Sender"),
          content: Column(
            children: [
              StepOneContent(),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text("Package"),
          content: StepTwoContent(),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text("Review"),
          content: StepThreeContent(),
        ),
      ];
}
