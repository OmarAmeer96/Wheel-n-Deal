import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_email_textfiled.dart';
import 'package:wheel_n_deal/Core/widgets/custom_password_textfield.dart';
import 'package:wheel_n_deal/constants.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  String? email;

  String? password;

  String? rePassword;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  // final _rePasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _form,
        child: CustomScrollView(
          // TO DO ->
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      "Welcome back! Glad to see you, Again!",
                      style: Styles.manropeExtraBold32,
                    ),
                    SizedBox(
                      height: 60,
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
                    CustomEmailTextField(
                      controller: _emailController,
                      onChanged: (data) {
                        email = data;
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
                      height: 15,
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
                      height: 10,
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
                      height: 26,
                    ),
                    CustomMainButton(
                      text: "Login",
                      onPressed: () {},
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
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t have an account?  "),
                      Text("Register Now"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isValidUsername(String username) {
  final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,30}$');
  return usernameRegex.hasMatch(username);
}
