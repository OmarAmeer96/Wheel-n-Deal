import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/profile/views/widgets/user_edit_profile_view_body.dart';

class UserEditProfileView extends StatefulWidget {
  const UserEditProfileView({super.key});

  @override
  State<UserEditProfileView> createState() => _UserEditProfileViewState();
}

class _UserEditProfileViewState extends State<UserEditProfileView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserEditProfileViewBody(),
    );
  }
}
