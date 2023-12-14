import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_field.dart';
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
                        height: 20,
                      ),
                      Text(
                        "Create new password",
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
                          'New Password',
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
                        obscureText: obscureRePassText,
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
                        obscureText: obscurePassText,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      CustomMainButton(
                        text: "Reset Password",
                        onPressed: () async {
                          if (_form.currentState!.validate()) {
                            GoRouter.of(context).push(
                              AppRouter.kPasswordChangedView,
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
            ],
          ),
        ),
      ),
    );
  }
}
