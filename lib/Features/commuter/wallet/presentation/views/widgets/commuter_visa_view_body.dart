import 'package:flutter/material.dart';

class CommuterVisaViewBody extends StatelessWidget {
  const CommuterVisaViewBody({super.key});

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
