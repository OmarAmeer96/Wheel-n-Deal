import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/views/widgets/password_changed_view_body.dart';

class PasswordChangedView extends StatelessWidget {
  const PasswordChangedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PasswordChangedViewBody(),
    );
  }
}
