import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/widgets/user_profile_view_body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserProfileViewBody(),
    );
  }
}
