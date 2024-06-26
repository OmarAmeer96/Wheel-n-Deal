import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:wheel_n_deal/Core/functions/setup_error_state.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';

import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/logic/commuter_post_trip_cubit/commuter_post_trip_cubit.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/logic/commuter_post_trip_cubit/commuter_post_trip_state.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/presentation/views/widgets/custom_time_picker_item.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/presentation/views/widgets/path_item.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/presentation/views/widgets/post_trip_from_select_location_item.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/make_order_to_select_location_item.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/user_stepper_steps_item.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterPostTripViewBody extends StatefulWidget {
  final TextEditingController? fromAddressController;
  final TextEditingController? toAddressController;
  const CommuterPostTripViewBody({
    super.key,
    this.fromAddressController,
    this.toAddressController,
  });

  @override
  State<CommuterPostTripViewBody> createState() =>
      _CommuterPostTripViewBodyState();
}

class _CommuterPostTripViewBodyState extends State<CommuterPostTripViewBody> {
  int currentStep = 0;

  // Step 1 Things
  String? from;
  String? to;

  String? location1;
  String? location2;
  String? location3;

  String? fromSelectedAddress;
  String? toSelectedAddress;
  final _location1Controller = TextEditingController();
  final _location2Controller = TextEditingController();
  final _location3Controller = TextEditingController();

  final _form1 = GlobalKey<FormState>();

  final FocusNode path1FocusNode = FocusNode();
  final FocusNode path2FocusNode = FocusNode();
  final FocusNode path3FocusNode = FocusNode();

  @override
  void dispose() {
    path1FocusNode.dispose();
    path2FocusNode.dispose();
    path3FocusNode.dispose();
    super.dispose();
  }

  // Step 2 Things
  final _form2 = GlobalKey<FormState>();

  DateTime? selectedDate;
  final _pickedDateController = TextEditingController();

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  String? orderName;
  String? weight;
  String? expectedPrice;

  final _orderCapacityController = TextEditingController();

  String? selectedCount = "1";

  String? selectedExpiryDate = "1-2 Days";

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
                    child: BlocListener<CommuterPostTripCubit,
                        CommuterPostTripState>(
                      listener: (context, state) {
                        state.whenOrNull(
                          loading: () {
                            showDialog(
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              ),
                            );
                          },
                          success: (postOrderResponse) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(postOrderResponse.message),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                            if (postOrderResponse.message ==
                                "Trip Created Successfully") {
                              context.pop();
                            }
                            context.pushNamed(Routes.kCommuterTripsView);
                          },
                          error: (error) {
                            setupErrorState(
                              context,
                              error,
                            );
                          },
                        );
                      },
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
                                  BlocProvider.of<CommuterPostTripCubit>(
                                          context)
                                      .emitPostTripState();
                                },
                                text: "Post",
                                color: kPrimaryColor,
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (currentStep == 0) {
              // if (_form1.currentState!.validate()) {
              //   setState(() {
              //     currentStep++;
              //   });
              // }
              setState(() {
                currentStep++;
              });
            } else if (currentStep == 1) {
              // if (_form2.currentState!.validate()) {
              //   setState(() {
              //     currentStep++;
              //   });
              // }
              setState(() {
                currentStep++;
              });
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
                      'Route Details',
                      style: Styles.manropeBold32.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
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
                        PostTripFromSelectLocationItem(
                          fromAddressController: widget.fromAddressController,
                          text: 'From',
                          fromSelectedAddress: context
                              .read<CommuterPostTripCubit>()
                              .fromAddressController
                              .text,
                          onPressed: () async {
                            final result = await context.pushNamed(
                              Routes.kCommuterSearchLocationView,
                            );
                            if (result != null) {
                              setState(() {
                                context
                                    .read<CommuterPostTripCubit>()
                                    .fromAddressController
                                    .text = result;
                                widget.fromAddressController?.text = result;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MakeOrderToSelectLocationItem(
                          toAddressController: widget.toAddressController,
                          text: 'To',
                          toSelectedAddress:
                              toSelectedAddress ?? "Select New Address",
                          onPressed: () async {
                            final result = await context.pushNamed(
                              Routes.kCommuterSearchLocationView,
                            );
                            if (result != null) {
                              setState(() {
                                fromSelectedAddress = result;
                                widget.fromAddressController?.text = result;
                              });
                            }
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
                            'List of paths',
                            style: Styles.manropeRegular15.copyWith(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'List the stations you will pass through during your trip to deliver the order.',
                          textAlign: TextAlign.center,
                          style: Styles.manropeRegular15.copyWith(
                            fontSize: 14,
                            color: const Color(0xffa4a4a4),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Positioned(
                              left: 24,
                              top: 24,
                              child: Container(
                                color: const Color(0xffa4a4a4),
                                width: 2,
                                height: 190,
                              ),
                            ),
                            Column(
                              children: [
                                PathItem(
                                  locationController: _location1Controller,
                                  hintText: 'Location 1',
                                  enabled: true,
                                  inputType: TextInputType.text,
                                  onChanged: (value) {
                                    value = location1;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the card number.';
                                    }
                                    return null;
                                  },
                                  focusNode: path1FocusNode,
                                  nextFocusNode: path2FocusNode,
                                ),
                                PathItem(
                                  locationController: _location2Controller,
                                  hintText: 'Location 2',
                                  enabled: true,
                                  inputType: TextInputType.text,
                                  onChanged: (value) {
                                    value = location2;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the card number.';
                                    }
                                    return null;
                                  },
                                  focusNode: path2FocusNode,
                                  nextFocusNode: path3FocusNode,
                                ),
                                PathItem(
                                  locationController: _location3Controller,
                                  hintText: 'Location 3',
                                  enabled: true,
                                  inputType: TextInputType.text,
                                  onChanged: (value) {
                                    value = location3;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the card number.';
                                    }
                                    return null;
                                  },
                                  focusNode: path3FocusNode,
                                ),
                              ],
                            ),
                          ],
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Trip Details',
                      style: Styles.manropeBold32.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StepItem(
                    widget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Time of the trip",
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
                              child: GestureDetector(
                                onTap: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null &&
                                      pickedDate != selectedDate) {
                                    setState(() {
                                      selectedDate = pickedDate;
                                      _pickedDateController.text =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);
                                    });
                                  }
                                },
                                child: SizedBox(
                                  height: 40,
                                  child: CustomMainTextFormField(
                                    enabled: false,
                                    borderColor: Colors.transparent,
                                    fillColor: Colors.transparent,
                                    hintText: 'DD/MM/YYYY',
                                    controller: _pickedDateController,
                                    onChanged: (value) {},
                                    contentPadding: 7,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter order's name.";
                                      }
                                      return null;
                                    },
                                    focusedBorderColor: const Color(0xff55433c),
                                    enabledBorderColor: kPrimaryColor,
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 1.0),
                                    ),
                                    inputType: TextInputType.text,
                                    obscureText: false,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTimePickerItem(
                          text: 'Start at',
                          onTimeSelected: (TimeOfDay selectedTime) {
                            setState(() {
                              selectedStartTime = selectedTime;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTimePickerItem(
                          text: 'End at',
                          onTimeSelected: (TimeOfDay selectedTime) {
                            setState(() {
                              selectedEndTime = selectedTime;
                            });
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
                            "Capacity of the order",
                            style: Styles.manropeRegular15.copyWith(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "How much can you take?",
                          textAlign: TextAlign.start,
                          style: Styles.manropeRegular15.copyWith(
                            fontSize: 17,
                            color: const Color(0xFFA3A3A3),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 140,
                              child: CustomMainTextFormField(
                                enabled: true,
                                borderColor: Colors.transparent,
                                fillColor: Colors.transparent,
                                hintText: '3',
                                controller: _orderCapacityController,
                                onChanged: (value) {},
                                contentPadding: 7,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter order's name.";
                                  }
                                  return null;
                                },
                                focusedBorderColor: const Color(0xff55433c),
                                enabledBorderColor: kPrimaryColor,
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: kPrimaryColor, width: 1.0),
                                ),
                                inputType: TextInputType.text,
                                obscureText: false,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "KG",
                              style: Styles.manropeExtraBold18.copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ],
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
                              valText: 'This is FROM test',
                            ),
                            CustomReviewSummaryItem(
                              keyText: 'To      ',
                              valText: 'This is TO test',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Trip Details",
                        style: Styles.manropeBold32.copyWith(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            const CustomReviewSummaryItem(
                              keyText: 'Day          ',
                              valText: 'Monday',
                            ),
                            CustomReviewSummaryItem(
                              keyText: 'Start at ',
                              valText: selectedStartTime.toString(),
                            ),
                            CustomReviewSummaryItem(
                              keyText: 'End at     ',
                              valText: selectedEndTime.toString(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Capacity',
                        valText: '3 KG',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ];
}
