import 'package:flutter/material.dart';

class CommuterWalletViewBody extends StatelessWidget {
  const CommuterWalletViewBody({super.key});

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
