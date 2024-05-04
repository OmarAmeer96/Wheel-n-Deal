import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/functions/is_valid_phone_number.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_cubit.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_state.dart';
import 'package:wheel_n_deal/constants.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  String? phoneNumber;

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
                  success: (sendOTPResponse) {
                    // log(sendOTPResponse.otpData.message, name: 'OTP');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(sendOTPResponse.message),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                    GoRouter.of(context).push(AppRouter.kOtpVerificationView);
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
                              "Forgot Password?",
                              style: Styles.manropeBold32,
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
                          CustomMainTextFormField(
                            onChanged: (data) {
                              phoneNumber = data;
                            },
                            controller: context
                                .read<ForgotPasswordCubit>()
                                .phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phone number.';
                              } else if (!isValidPhoneNumber(value)) {
                                return 'Please enter a valid Egyptian phone number.';
                              }
                              return null;
                            },
                            labelText: "Phone Number",
                            hintText: "01554111002",
                            borderColor: Colors.transparent,
                            focusedBorderColor: Colors.transparent,
                            enabledBorderColor: Colors.transparent,
                            inputType: TextInputType.phone,
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: kPrimaryColor,
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
                              validateThenSendOTP(context);
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
            )),
      ),
    );
  }

  void validateThenSendOTP(BuildContext context) {
    if (_form.currentState!.validate()) {
      BlocProvider.of<ForgotPasswordCubit>(context).emitSendOTPState();
    }
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
          'Faliled to send OTP.\n$error',
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
