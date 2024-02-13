import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/constants.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  String? oldPassword;

  String? newPassword;

  String? reNewPassword;

  final _oldPasswordController = TextEditingController();

  final _newPasswordController = TextEditingController();

  final _reNewPasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool obscureOldPassText = true;
  bool obscureNewPassText = true;
  bool obscureReNewPassText = true;

  void _toggleOldPasswordIcon() {
    obscureOldPassText = !obscureOldPassText;
    setState(() {});
  }

  void _toggleNewPasswordIcon() {
    obscureNewPassText = !obscureNewPassText;
    setState(() {});
  }

  void _toggleReNewPasswordIcon() {
    obscureReNewPassText = !obscureReNewPassText;
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Create New Password",
                          style: Styles.manropeMedium18.copyWith(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Your new password must be unique from those previously used.",
                          style: Styles.manropeRegular15.copyWith(
                            fontSize: 15,
                            color: const Color(0xFFA3A3A3),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                          'Old Password',
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
                          oldPassword = data;
                        },
                        controller: _oldPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the old password.';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                        hintText: 'Enter Old Password',
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
                            _toggleOldPasswordIcon();
                          },
                          child: Icon(
                            obscureNewPassText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                        obscureText: obscureOldPassText,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            GoRouter.of(context)
                                .push(AppRouter.kForgotPasswodView);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: Styles.manropeRegular16.copyWith(
                              color: kPrimaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
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
                          newPassword = data;
                        },
                        controller: _newPasswordController,
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
                            _toggleNewPasswordIcon();
                          },
                          child: Icon(
                            obscureNewPassText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                        obscureText: obscureNewPassText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Confirm New Password',
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
                          reNewPassword = data;
                        },
                        controller: _reNewPasswordController,
                        validator: (value) {
                          if (value != _newPasswordController.text) {
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
                            _toggleReNewPasswordIcon();
                          },
                          child: Icon(
                            obscureReNewPassText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                        obscureText: obscureReNewPassText,
                      ),
                      const SizedBox(
                        height: 16,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomMainButton(
                          text: "Reset Password",
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              GoRouter.of(context)
                                  .push(AppRouter.kPasswordChanged2View);
                            }
                          },
                          color: kPrimaryColor,
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
