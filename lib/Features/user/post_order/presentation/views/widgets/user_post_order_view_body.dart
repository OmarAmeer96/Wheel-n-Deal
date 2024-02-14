import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/is_valid_phone_number.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/make_order_select_location_item.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/user_stepper_steps_item.dart';
import 'package:wheel_n_deal/constants.dart';

class UserPostOrderViewBody extends StatefulWidget {
  const UserPostOrderViewBody({super.key});

  @override
  State<UserPostOrderViewBody> createState() => _UserPostOrderViewBodyState();
}

class _UserPostOrderViewBodyState extends State<UserPostOrderViewBody> {
  int currentStep = 0;

  String? from;
  String? to;
  String? senderName;
  String? senderPhoneNumber;
  String? receiverPhoneNumber;

  // ignore: unused_field
  final _fromController = TextEditingController();
  // ignore: unused_field
  final _toController = TextEditingController();
  final _senderNameController = TextEditingController();
  final _senderPhoneNumberController = TextEditingController();
  final _receiverPhoneNumberController = TextEditingController();

  final _form = GlobalKey<FormState>();

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
          onStepContinue: () async {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              log("Completed");
            } else if (_form.currentState!.validate()) {
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
          content: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sender Details',
                      style: Styles.manropeExtraBold32.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SteponeItem(
                    widget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Address Details',
                            style: Styles.manropeRegular15.copyWith(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MakeOrderSelectLocationIte(
                          text: 'From',
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MakeOrderSelectLocationIte(
                          text: 'To',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SteponeItem(
                    widget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sender's Name",
                            style: Styles.manropeRegular15.copyWith(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomMainTextFormField(
                          borderColor: Colors.transparent,
                          fillColor: Colors.transparent,
                          hintText: 'Input your name..',
                          controller: _senderNameController,
                          onChanged: (value) {
                            senderName = value;
                          },
                          contentPadding: 7,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter sender's name.";
                            }
                            return null;
                          },
                          focusedBorderColor: const Color(0xff55433c),
                          enabledBorderColor: kPrimaryColor,
                          inputType: TextInputType.text,
                          prefixIcon: const Icon(Icons.person),
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SteponeItem(
                    widget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sender's phone number",
                            style: Styles.manropeRegular15.copyWith(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomMainTextFormField(
                          borderColor: Colors.transparent,
                          fillColor: Colors.transparent,
                          hintText: 'Input your number..',
                          controller: _senderPhoneNumberController,
                          onChanged: (value) {
                            senderName = value;
                          },
                          contentPadding: 7,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter sender's phone number.";
                            } else if (!isValidPhoneNumber(value)) {
                              return 'Please enter a valid Egyptian phone number.';
                            }
                            return null;
                          },
                          focusedBorderColor: const Color(0xff55433c),
                          enabledBorderColor: kPrimaryColor,
                          inputType: TextInputType.number,
                          prefixIcon: const Icon(Icons.phone),
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SteponeItem(
                    widget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Receiver's phone number",
                            style: Styles.manropeRegular15.copyWith(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomMainTextFormField(
                          borderColor: Colors.transparent,
                          fillColor: Colors.transparent,
                          hintText: "Input receiver's number..",
                          controller: _receiverPhoneNumberController,
                          onChanged: (value) {
                            receiverPhoneNumber = value;
                          },
                          contentPadding: 7,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Receiver's phone number.";
                            } else if (!isValidPhoneNumber(value)) {
                              return 'Please enter a valid Egyptian phone number.';
                            }
                            return null;
                          },
                          focusedBorderColor: const Color(0xff55433c),
                          enabledBorderColor: kPrimaryColor,
                          inputType: TextInputType.number,
                          prefixIcon: const Icon(Icons.phone),
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text("Package"),
          content: Container(),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text("Review"),
          content: Container(),
        ),
      ];
}
