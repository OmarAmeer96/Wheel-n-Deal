import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class UserHomeViewBody extends StatelessWidget {
  const UserHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "User Home Screen\n🌚",
          textAlign: TextAlign.center,
          style: Styles.manropeExtraBold32.copyWith(
            fontWeight: FontWeight.w900,
            color: Colors.deepOrange,
            fontSize: 60,
          ),
        ),
      ),
    );
  }
}
