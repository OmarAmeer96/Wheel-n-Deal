import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/user_stepper_steps_item.dart';
import 'package:wheel_n_deal/constants.dart';

class SetAnotherExpectedPriceViewBody extends StatefulWidget {
  const SetAnotherExpectedPriceViewBody({super.key});

  @override
  State<SetAnotherExpectedPriceViewBody> createState() =>
      _SetAnotherExpectedPriceViewBodyState();
}

class _SetAnotherExpectedPriceViewBodyState
    extends State<SetAnotherExpectedPriceViewBody> {
  final _form = GlobalKey<FormState>();
  String? expectedPrice;

  final _expectedPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: const Color(0x7FA3A3A3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
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
                              style:
                                  Styles.manropeBold32.copyWith(fontSize: 15),
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
                              style:
                                  Styles.manropeBold32.copyWith(fontSize: 15),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  CustomReviewSummaryItem(
                                    keyText: 'Name   ',
                                    valText: 'Camera',
                                  ),
                                  CustomReviewSummaryItem(
                                    keyText: 'Count  ',
                                    valText: '2',
                                  ),
                                  CustomReviewSummaryItem(
                                    keyText: 'Weight',
                                    valText: '0.5 KG',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: CircleAvatar(
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
                            const CustomReviewSummaryItem(
                              keyText: 'Breakable Order',
                              valText: "Yes",
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
                            CustomReviewSummaryItem(
                              keyText: 'Expected Price',
                              valText: expectedPrice == null
                                  ? "100"
                                  : expectedPrice!,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Set another expected price",
                        style: Styles.manropeBold32.copyWith(fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StepItem(
                      widget: Column(
                        mainAxisSize: MainAxisSize.max,
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
                              setState(() {});
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
                      height: 100,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: CustomMainButton(
                  onPressed: () {
                    GoRouter.of(context)
                        .push(AppRouter.kDoneWaitForCustomerConfirmationView);
                  },
                  text: "Pick with the new price",
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
