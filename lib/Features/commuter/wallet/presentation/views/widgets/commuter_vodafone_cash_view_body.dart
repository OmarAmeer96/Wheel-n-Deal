import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/is_valid_phone_number.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_visa_vodacash_text_field.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterVodafoneCashViewBody extends StatefulWidget {
  const CommuterVodafoneCashViewBody({super.key});

  @override
  State<CommuterVodafoneCashViewBody> createState() =>
      _CommuterVodafoneCashViewBodyState();
}

class _CommuterVodafoneCashViewBodyState
    extends State<CommuterVodafoneCashViewBody> {
  String? phoneNumber;

  final _phoneNumberController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Focus.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: _form,
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "By Visa",
                        style: Styles.manropeSemiBold16.copyWith(
                          fontSize: 20,
                          letterSpacing: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomVisaVodaCashTextField(
                      onChanged: (data) {
                        phoneNumber = data;
                      },
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the phone number.';
                        } else if (value.length != 11) {
                          return 'phone number must be 11 numbers length.';
                        } else if (!isValidPhoneNumber(value)) {
                          return 'Please enter a valid Egyptian phone number.';
                        }
                        return null;
                      },
                      labelText: "Phone Number",
                      hintText: "01045457788",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(AssetsData.vodafoneCashIcon),
                      ),
                      enabled: true,
                      inputType: TextInputType.number,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: CustomMainButton(
                    text: "Add Card",
                    onPressed: () async {
                      if (_form.currentState!.validate()) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                      'Added Successfully!',
                                      style: Styles.manropeBold32
                                          .copyWith(fontSize: 26),
                                    ),
                                    const Spacer(),
                                    CustomMainButton(
                                      text: "Back",
                                      onPressed: () {
                                        GoRouter.of(context).push(
                                            AppRouter.kCommuterWalletView);
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
                      }
                    },
                    color: kPrimaryColor,
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
