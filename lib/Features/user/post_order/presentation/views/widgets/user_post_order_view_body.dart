import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
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

  // Step 1 Things
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

  final _form1 = GlobalKey<FormState>();

  // Step 2 Things
  final _form2 = GlobalKey<FormState>();
  String? orderName;
  String? weight;
  String? expectedPrice;

  final _orderNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _expectedPriceController = TextEditingController();

  String? selectedCount = "1";

  String? selectedExpiryDate = "1-2 Days";

  bool _switchValue = false;

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
            log(currentStep.toString());
            if (isLastStep) {
              log("Completed");
            }
            if (currentStep == 0) {
              if (_form1.currentState!.validate()) {
                setState(() {
                  currentStep++;
                });
              }
            } else if (currentStep == 1) {
              if (_form2.currentState!.validate()) {
                setState(() {
                  currentStep++;
                });
              }
            } else {
              log(currentStep.toString());
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
              key: _form1,
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
                          onPressed: () {
                            GoRouter.of(context).push(
                              AppRouter.kUserSearchLocationView,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MakeOrderSelectLocationIte(
                          text: 'To',
                          onPressed: () {
                            GoRouter.of(context).push(
                              AppRouter.kUserSearchLocationView,
                            );
                          },
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
          content: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _form2,
              child: Column(
                children: [
                  SteponeItem(
                    widget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Details",
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
                          hintText: 'Name of order',
                          controller: _orderNameController,
                          onChanged: (value) {
                            orderName = value;
                          },
                          contentPadding: 7,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter order's name.";
                            }
                            return null;
                          },
                          focusedBorderColor: const Color(0xff55433c),
                          enabledBorderColor: kPrimaryColor,
                          inputType: TextInputType.text,
                          prefixIcon: SvgPicture.asset(
                            AssetsData.ordersIcon,
                            // ignore: deprecated_member_use
                            color: Colors.black,
                            width: 22,
                          ),
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Count of orders',
                            style:
                                Styles.manropeRegular14.copyWith(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              child: Row(
                                children: [
                                  Radio(
                                    focusColor: const Color(0xff99A0A8),
                                    fillColor: const MaterialStatePropertyAll(
                                      kPrimaryColor,
                                    ),
                                    value: '1',
                                    groupValue: selectedCount,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCount = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    '1',
                                    style: Styles.poppinsSemiBold16
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 20,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Radio(
                                    focusColor: const Color(0xff99A0A8),
                                    fillColor: const MaterialStatePropertyAll(
                                      kPrimaryColor,
                                    ),
                                    value: '2',
                                    groupValue: selectedCount,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCount = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    '2',
                                    style: Styles.poppinsSemiBold16
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 20,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Radio(
                                    focusColor: const Color(0xff99A0A8),
                                    fillColor: const MaterialStatePropertyAll(
                                      kPrimaryColor,
                                    ),
                                    value: '3',
                                    groupValue: selectedCount,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCount = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    '3',
                                    style: Styles.poppinsSemiBold16
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 20,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Radio(
                                    focusColor: const Color(0xff99A0A8),
                                    fillColor: const MaterialStatePropertyAll(
                                      kPrimaryColor,
                                    ),
                                    value: '4 or more',
                                    groupValue: selectedCount,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCount = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    '4 or more',
                                    style: Styles.poppinsSemiBold16
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                            "Order's weight",
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
                          hintText: "Input order's weight",
                          controller: _weightController,
                          onChanged: (value) {
                            weight = value;
                          },
                          contentPadding: 7,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter orde's weight.";
                            }
                            return null;
                          },
                          focusedBorderColor: const Color(0xff55433c),
                          enabledBorderColor: kPrimaryColor,
                          inputType: TextInputType.number,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.weightHanging,
                            size: 22,
                          ),
                          obscureText: false,
                          suffixIcon: const Text(
                            "KG",
                            style: Styles.manropeRegular14,
                          ),
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
                            "Epected Price",
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
                          hintText: "0",
                          controller: _expectedPriceController,
                          onChanged: (value) {
                            expectedPrice = value;
                          },
                          contentPadding: 7,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the expected price.";
                            }
                            return null;
                          },
                          focusedBorderColor: const Color(0xff55433c),
                          enabledBorderColor: kPrimaryColor,
                          inputType: TextInputType.number,
                          prefixIcon: const Icon(Icons.price_change_outlined),
                          obscureText: false,
                          suffixIcon: const Text(
                            "LE",
                            style: Styles.manropeRegular14,
                          ),
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
                        Row(
                          children: [
                            Text(
                              "Breakable Order",
                              style: Styles.manropeRegular15.copyWith(
                                fontSize: 17,
                              ),
                            ),
                            const Spacer(),
                            CupertinoSwitch(
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                          ],
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
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Count of orders',
                          style: Styles.manropeRegular14.copyWith(fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            child: Row(
                              children: [
                                Radio(
                                  focusColor: const Color(0xff99A0A8),
                                  fillColor: const MaterialStatePropertyAll(
                                    kPrimaryColor,
                                  ),
                                  value: '1-2 Days',
                                  groupValue: selectedExpiryDate,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedExpiryDate = value;
                                    });
                                  },
                                ),
                                Text(
                                  '1-2 Days',
                                  style: Styles.poppinsSemiBold16
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Radio(
                                  focusColor: const Color(0xff99A0A8),
                                  fillColor: const MaterialStatePropertyAll(
                                    kPrimaryColor,
                                  ),
                                  value: '3-5 Days',
                                  groupValue: selectedExpiryDate,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedExpiryDate = value;
                                    });
                                  },
                                ),
                                Text(
                                  '3-5 Days',
                                  style: Styles.poppinsSemiBold16
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Radio(
                                  focusColor: const Color(0xff99A0A8),
                                  fillColor: const MaterialStatePropertyAll(
                                    kPrimaryColor,
                                  ),
                                  value: '1 Week',
                                  groupValue: selectedExpiryDate,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedExpiryDate = value;
                                    });
                                  },
                                ),
                                Text(
                                  '1 Week',
                                  style: Styles.poppinsSemiBold16
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text("Review"),
          content: Container(),
        ),
      ];
}
