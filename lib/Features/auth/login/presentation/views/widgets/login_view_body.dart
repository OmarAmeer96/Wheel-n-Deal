import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheel_n_deal/Core/utils/custom_main_button.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_text_field.dart';
import 'package:wheel_n_deal/constants.dart';

import '../../../../../../Core/utils/assets.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final TextEditingController loginUserNameController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome back! Glad to see you, Again!",
              style: Styles.manropeRegular38,
            ),
            const SizedBox(
              height: 66,
            ),
            CustomTextField(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: SvgPicture.asset(
                  AssetsData.userName,
                ),
              ),
              controller: loginUserNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              labelText: "Enter Name",
              headerTextField: 'Username',
              labelColor: const Color(0xffA4A4A4),
            ),
            const SizedBox(
              height: 14,
            ),
            CustomTextField(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: SvgPicture.asset(
                  AssetsData.passWord,
                ),
              ),
              controller: loginPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
              labelText: "Enter Password",
              headerTextField: 'Password',
              labelColor: const Color(0xffA4A4A4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Forgot Password",
                    style: Styles.manropeRegular12.copyWith(
                      color: const Color(0xff6A707C),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            CustomMainButton(
              text: "Login",
              onPressed: () {},
              color: kPrimaryColor,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account?   ",
                  style: Styles.manropeRegular12.copyWith(
                    color: const Color(0xff191D31),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Register Now",
                    style: Styles.manropeRegular12.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 26,
            )
          ],
        ),
      ),
    );
  }
}
