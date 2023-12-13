import 'package:flutter/material.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  String? phoneNumber;

  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Placeholder(),
    );
  }
}
