import 'package:flutter/material.dart';

class RegisterBodyView extends StatefulWidget {
  const RegisterBodyView({super.key});

  @override
  State<RegisterBodyView> createState() => _RegisterBodyViewState();
}

class _RegisterBodyViewState extends State<RegisterBodyView> {
  String? username;

  String? password;

  String? rePassword;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _rePasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Placeholder(),
    );
  }
}
