import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/auth/register/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterBodyView(),
    );
  }
}
