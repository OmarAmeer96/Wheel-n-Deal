import 'package:flutter/material.dart';

class CommuterConfirmOrder1ViewBody extends StatelessWidget {
  const CommuterConfirmOrder1ViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
