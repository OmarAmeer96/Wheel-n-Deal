import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/image_picker_bottom_sheet.dart';
import 'package:wheel_n_deal/Core/utils/is_valid_phone_number.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';
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

  File? _selectedImage;

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
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                context: context,
                builder: (context) {
                  return SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
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
                              height: 40,
                            ),
                            CustomMainButton(
                              onPressed: () {
                                GoRouter.of(context)
                                    .push(AppRouter.kUserOrdersView);
                              },
                              text: "Post Public",
                              color: kPrimaryColor,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomMainButton(
                              onPressed: () {
                                GoRouter.of(context).push(
                                    AppRouter.kDoneNotifyFavCommutersView);
                              },
                              text: "Notify All Favorites",
                              textColor: Colors.black,
                              color: const Color(0xfff3f3f3),
                              borderSideColor: Colors.black,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
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
                      style: Styles.manropeBold32.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StepItem(
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
                  StepItem(
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
                  StepItem(
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
                  StepItem(
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
                  StepItem(
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomMainTextFormField(
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
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  AssetsData.cameraIcon,
                                  // ignore: deprecated_member_use
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  imagePickerBottomSheet(context, onTap1: () {
                                    _pickImageFromCamera();
                                  }, onTap2: () {
                                    _pickImageFromGallery();
                                  });
                                },
                              ),
                            ),
                          ],
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
                  StepItem(
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
                  StepItem(
                    widget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Expected Price",
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
                  StepItem(
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
                  StepItem(
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
          content: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Review Summary",
                  style: Styles.manropeRegular15.copyWith(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: const Color(0x7FA3A3A3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomReviewSummaryItem(
                        keyText: 'Sender Name',
                        valText: 'Omar',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Sender Phone Number',
                        valText: '01554111002',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Receiver Phone Number',
                        valText: '01554111002',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Address",
                        style: Styles.manropeBold32.copyWith(fontSize: 15),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            CustomReviewSummaryItem(
                              keyText: 'From',
                              valText: 'Port-said mohammed ali St',
                            ),
                            CustomReviewSummaryItem(
                              keyText: 'To      ',
                              valText: 'Tanta',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Order Details",
                        style: Styles.manropeBold32.copyWith(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            const CustomReviewSummaryItem(
                              keyText: 'Name   ',
                              valText: 'Camera',
                            ),
                            const CustomReviewSummaryItem(
                              keyText: 'Count  ',
                              valText: '2',
                            ),
                            const CustomReviewSummaryItem(
                              keyText: 'Weight',
                              valText: '0.5 KG',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: _selectedImage != null
                                  ? CircleAvatar(
                                      backgroundImage: FileImage(
                                        _selectedImage!,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                        AssetsData.profileImage,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomReviewSummaryItem(
                        keyText: 'Breakable Order',
                        valText: _switchValue.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Expiry Date',
                        valText: '3-5 Dayes',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Expected Price',
                        valText: '100 LE',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ];

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
