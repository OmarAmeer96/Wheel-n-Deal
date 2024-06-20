import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_cubit.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_state.dart';
import 'package:wheel_n_deal/constants.dart';

class CreateNewPasswordViewBody extends StatefulWidget {
  const CreateNewPasswordViewBody({super.key});

  @override
  State<CreateNewPasswordViewBody> createState() =>
      _CreateNewPasswordViewBodyState();
}

class _CreateNewPasswordViewBodyState extends State<CreateNewPasswordViewBody> {
  String? password;

  String? rePassword;

  // final _passwordController = TextEditingController();

  final _rePasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool obscurePassText = true;
  bool obscureRePassText = true;

  void _togglePasswordIcon() {
    obscurePassText = !obscurePassText;
    setState(() {});
  }

  void _toggleRePasswordIcon() {
    obscureRePassText = !obscureRePassText;
    setState(() {});
  }

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
              success: (forgotPasswordResponse) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(forgotPasswordResponse.message),
                    duration: const Duration(seconds: 3),
                  ),
                );
                if (forgotPasswordResponse.message ==
                    "Password updated successfully.") {
                  GoRouter.of(context).push(AppRouter.kPasswordChangedView);
                }
              },
              error: (error) {
                setupErrorState(context, error);
              },
            );
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Create new password",
                        style: Styles.manropeBold32,
                      ),
                      SizedBox(
                        height: 70,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'New Password',
                          style: Styles.poppinsSemiBold16.copyWith(
                            color: const Color(0xFFA3A3A3),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomMainTextFormField(
                        onChanged: (data) {
                          password = data;
                        },
                        controller: context
                            .read<ForgotPasswordCubit>()
                            .newPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password.';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                        hintText: 'Enter Password',
                        borderColor: const Color(0xFFA3A3A3),
                        focusedBorderColor: const Color(0xff55433c),
                        enabledBorderColor: const Color(0xFFA3A3A3),
                        inputType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SvgPicture.asset(AssetsData.passWord),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            _togglePasswordIcon();
                          },
                          child: Icon(
                            obscurePassText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                        obscureText: obscurePassText,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Confirm Password',
                          style: Styles.poppinsSemiBold16.copyWith(
                            color: const Color(0xFFA3A3A3),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomMainTextFormField(
                        onChanged: (data) {
                          rePassword = data;
                        },
                        controller: _rePasswordController,
                        validator: (value) {
                          if (value !=
                              context
                                  .read<ForgotPasswordCubit>()
                                  .newPasswordController
                                  .text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                        hintText: 'Re-Enter Password',
                        borderColor: const Color(0xFFA3A3A3),
                        focusedBorderColor: const Color(0xff55433c),
                        enabledBorderColor: const Color(0xFFA3A3A3),
                        inputType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SvgPicture.asset(AssetsData.passWord),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            _toggleRePasswordIcon();
                          },
                          child: Icon(
                            obscureRePassText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                        obscureText: obscureRePassText,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Hero(
                        tag: 'sendOTPCodeButton',
                        child: CustomMainButton(
                          text: "Reset Password",
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              BlocProvider.of<ForgotPasswordCubit>(context)
                                  .emitForgotPasswordState();
                            }
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
            ],
          ),
        ),
      ),
    ));
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
