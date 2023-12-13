import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/is_valid_username.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_username_textfiled.dart';
import 'package:wheel_n_deal/Core/widgets/custom_password_textfield.dart';
import 'package:wheel_n_deal/constants.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  String? username;

  String? password;

  String? rePassword;

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  // final _rePasswordController = TextEditingController();

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
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome back! Glad to see you, Again!",
                        style: Styles.manropeExtraBold32,
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
                          'Username',
                          style: Styles.poppinsSemiBold16.copyWith(
                            color: const Color(0xFFA3A3A3),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomEmailTextField(
                        controller: _usernameController,
                        onChanged: (data) {
                          username = data;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username.';
                          } else if (!isValidUsername(value)) {
                            return 'Please enter a valid username.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: Styles.poppinsSemiBold16.copyWith(
                            color: const Color(0xFFA3A3A3),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomPasswordTextField(
                        controller: _passwordController,
                        text: "Password",
                        onChanged: (data) {
                          password = data;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password.';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            "Forgot Password?",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomMainButton(
                        text: "Login",
                        onPressed: () async {
                          if (_form.currentState!.validate()) {
                            // ignore: use_build_context_synchronously
                            GoRouter.of(context).push(AppRouter.kUserHomeView);
                          }
                        },
                        color: kPrimaryColor,
                      ),
                      // For Register Screen
                      // CustomPasswordTextField(
                      //       controller: _rePasswordController,
                      //       text: "RE-PASSWORD",
                      //       onChanged: (data) {
                      //         rePassword = data;
                      //       },
                      //       validator: (value) {
                      //         if (value != _passwordController.text) {
                      //           return 'Passwords do not match.';
                      //         }
                      //         return null;
                      //       },
                      //     ),

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
                          "Don’t have an account?  ",
                          style: Styles.manropeRegular15.copyWith(
                            color: const Color(0xFF191D31),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.kRegisterView);
                          },
                          child: Text(
                            "Register Now",
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
