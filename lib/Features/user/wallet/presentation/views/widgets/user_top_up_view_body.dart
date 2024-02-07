import 'package:flutter/material.dart';

class UserTopUpViewBody extends StatelessWidget {
  const UserTopUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(onTap: () {
        FocusScope.of(context).unfocus();
      }),
    );
  }
}
