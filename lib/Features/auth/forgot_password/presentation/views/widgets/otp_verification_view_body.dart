import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_cubit.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_state.dart';
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
            child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listenWhen: (previous, current) =>
              current is Loading || current is Success || current is Error,
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
              success: (validateOTPResponse) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(validateOTPResponse.message),
                    duration: const Duration(seconds: 3),
                  ),
                );
                if (validateOTPResponse.message != "OTP sent successfully.") {
                  GoRouter.of(context).push(AppRouter.kCreateNewPasswordView);
                }
              },
              error: (error) {
                setupErrorState(context, error);
              },
            );
          },
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
                      OtpTextFieldsRow(
                        otpController1:
                            context.read<ForgotPasswordCubit>().otpController1,
                        otpController2:
                            context.read<ForgotPasswordCubit>().otpController2,
                        otpController3:
                            context.read<ForgotPasswordCubit>().otpController3,
                        otpController4:
                            context.read<ForgotPasswordCubit>().otpController4,
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
                      const SizedBox(
                        height: 40,
                      ),
                      Hero(
                        tag: 'sendOTPCodeButton',
                        child: CustomMainButton(
                          text: "Verify",
                          onPressed: () {
                            BlocProvider.of<ForgotPasswordCubit>(context)
                                .emitValidateOTP();
                          },
                          color: kPrimaryColor,
                        ),
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
                          onTap: () {
                            BlocProvider.of<ForgotPasswordCubit>(context)
                                .emitSendOTPState();
                          },
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
        )),
      ),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          textAlign: TextAlign.center,
          style: Styles.manropeBold32.copyWith(
            color: kPrimaryColor,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: Styles.manropeBold32.copyWith(
                color: kPrimaryColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
