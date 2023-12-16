import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/profile/views/widgets/user_profile_view_body.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return const UserProfileViewBody();
  }
}
