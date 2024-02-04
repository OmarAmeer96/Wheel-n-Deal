import 'package:flutter/material.dart';

class UserVodafoneCashViewBody extends StatelessWidget {
  const UserVodafoneCashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Focus.of(context).unfocus();
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}
