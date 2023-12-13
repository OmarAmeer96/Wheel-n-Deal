import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/views/widgets/create_new_password_view_body.dart';

class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateNewPasswordViewBody(),
    );
  }
}
