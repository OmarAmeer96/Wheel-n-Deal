import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/is_valid_phone_number.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_field.dart';
import 'package:wheel_n_deal/constants.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  String? phoneNumber;

  final _phoneNumberController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _form,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot Password?",
                          style: Styles.manropeExtraBold32,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Don't worry! It occurs. Please enter phone number linked with your account.",
                          style: Styles.manropeRegular15.copyWith(
                            color: const Color(0xFFA3A3A3),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CustomMainTextField(
                        onChanged: (data) {
                          phoneNumber = data;
                        },
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number.';
                          } else if (!isValidPhoneNumber(value)) {
                            return 'Please enter a valid Egyptian phone number.';
                          }
                          return null;
                        },
                        hintText: 'Enter Phone Number',
                        borderColor: Colors.transparent,
                        focusedBorderColor: Colors.transparent,
                        enabledBorderColor: Colors.transparent,
                        inputType: TextInputType.phone,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SvgPicture.asset(AssetsData.phoneIcon),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 21),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "+20",
                                style: Styles.poppinsSemiBold16,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Image.asset(
                                AssetsData.egyptFlagPng,
                                height: 26,
                              ),
                            ],
                          ),
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomMainButton(
                        text: "Send Code",
                        onPressed: () async {
                          if (_form.currentState!.validate()) {
                            GoRouter.of(context).push(
                              AppRouter.kOtpVerificationView,
                            );
                          }
                        },
                        color: kPrimaryColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
