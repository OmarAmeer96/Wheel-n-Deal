import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/widgets/otp_text_fields_row.dart';
import 'package:wheel_n_deal/constants.dart';

class OtpVerificationViewBody extends StatelessWidget {
  const OtpVerificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
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
                          "OTP Verification",
                          style: Styles.manropeBold32,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter the verification code we just sent to your phone number!",
                          style: Styles.manropeRegular15.copyWith(
                            color: const Color(0xFFA3A3A3),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      // Text Fields Here
                      const OtpTextFieldsRow(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      CustomMainButton(
                        text: "Verify",
                        onPressed: () {
                          GoRouter.of(context).push(
                            AppRouter.kCreateNewPasswordView,
                          );
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
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn’t receive the code?  ",
                          style: Styles.manropeRegular15.copyWith(
                            color: const Color(0xFF191D31),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Resend",
                            style: Styles.manropeRegular15.copyWith(
                              color: const Color(0xFFFF981A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}