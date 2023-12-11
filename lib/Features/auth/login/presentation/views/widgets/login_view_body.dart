import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome back! Glad to see you, Again!",
              style: Styles.manropeRegular,
            ),
          ],
        ),
      ),
    );
  }
}
