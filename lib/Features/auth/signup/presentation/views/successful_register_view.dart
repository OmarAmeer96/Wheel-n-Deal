import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/auth/signup/presentation/views/widgets/successful_register_view_body.dart';

class SuccessfulRegisterView extends StatelessWidget {
  const SuccessfulRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SuccessfulRegisterViewBody(),
    );
  }
}
