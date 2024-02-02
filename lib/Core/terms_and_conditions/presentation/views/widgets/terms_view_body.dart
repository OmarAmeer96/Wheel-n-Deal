import 'package:flutter/material.dart';

class TermsViewBody extends StatelessWidget {
  const TermsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
