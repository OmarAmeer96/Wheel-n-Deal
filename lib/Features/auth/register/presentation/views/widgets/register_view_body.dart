import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/is_valid_phone_number.dart';
import 'package:wheel_n_deal/Core/utils/is_valid_username.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_field.dart';
import 'package:wheel_n_deal/constants.dart';

class RegisterBodyView extends StatefulWidget {
  const RegisterBodyView({super.key});

  @override
  State<RegisterBodyView> createState() => _RegisterBodyViewState();
}

class _RegisterBodyViewState extends State<RegisterBodyView> {
  String? username;

  String? password;

  String? rePassword;

  String? phoneNumber;

  final _usernameController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _passwordController = TextEditingController();

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
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hello! Register to get started",
                        style: Styles.manropeExtraBold32,
                      ),
                      SizedBox(
                        height: 30,
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
                      CustomMainTextField(
                        onChanged: (data) {
                          username = data;
                        },
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username.';
                          } else if (!isValidUsername(value)) {
                            return 'Please enter a valid username.';
                          }
                          return null;
                        },
                        hintText: 'Enter Name',
                        borderColor: const Color(0xFFA3A3A3),
                        focusedBorderColor: const Color(0xff55433c),
                        enabledBorderColor: const Color(0xFFA3A3A3),
                        inputType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SvgPicture.asset(AssetsData.userName),
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Phone Number',
                          style: Styles.poppinsSemiBold16.copyWith(
                            color: const Color(0xFFA3A3A3),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
                        borderColor: const Color(0xFFA3A3A3),
                        focusedBorderColor: const Color(0xff55433c),
                        enabledBorderColor: const Color(0xFFA3A3A3),
                        inputType: TextInputType.phone,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SvgPicture.asset(AssetsData.phoneIcon),
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 10,
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
                      CustomMainTextField(
                        onChanged: (data) {
                          password = data;
                        },
                        controller: _passwordController,
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
                        height: 10,
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
                      CustomMainTextField(
                        onChanged: (data) {
                          rePassword = data;
                        },
                        controller: _rePasswordController,
                        validator: (value) {
                          if (value != _passwordController.text) {
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
                      CustomMainButton(
                        text: "Register",
                        onPressed: () async {
                          if (_form.currentState!.validate()) {
                            GoRouter.of(context)
                                .push(AppRouter.kSuccessfulRegisterView);
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
                          "Aleady have an account?  ",
                          style: Styles.manropeRegular15.copyWith(
                            color: const Color(0xFF191D31),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                          child: Text(
                            "Login",
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
