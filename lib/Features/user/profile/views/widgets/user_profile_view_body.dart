import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/profile/views/widgets/edit_profile_button.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: Responsive.screenWidth(context),
              child: Image.asset(
                AssetsData.backGroundImage,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              right: 25,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "My Profile",
                        style: Styles.manropeExtraBold32.copyWith(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 56,
                        child: Image.asset(
                          AssetsData.profileImage,
                        ),
                      ),
                      const SizedBox(
                        width: 17,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Name",
                            style: Styles.cairoSemiBold,
                          ),
                          Text(
                            "+20 1554111002",
                            style: Styles.cairoSemiBold,
                          ),
                        ],
                      ),
                      const Spacer(),
                      EditProfileButton(
                        color: const Color(0x4CA3A3A3),
                        text: 'Edit Profile',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 26,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Features",
                  style: Styles.manropeRegular16.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
