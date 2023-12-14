import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CommuterHomeViewBody extends StatelessWidget {
  const CommuterHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "Commuter Home Screen",
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
