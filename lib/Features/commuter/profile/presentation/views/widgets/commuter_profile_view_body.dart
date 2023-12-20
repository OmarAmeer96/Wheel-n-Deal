import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/widgets/edit_profile_button.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/widgets/user_profile_item.dart';

class CommuterProfileViewBody extends StatelessWidget {
  const CommuterProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                          onPressed: () {
                            GoRouter.of(context).push(
                              AppRouter.kCommuterEditProfileView,
                            );
                          },
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
                    "Settings",
                    style: Styles.manropeExtraBold32.copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'Language',
                  icon: AssetsData.languageIcon,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'My Wallet',
                  icon: AssetsData.walletIcon,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'Notifications',
                  icon: AssetsData.bellIcon,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'Change Password',
                  icon: AssetsData.passWord,
                ),
                const SizedBox(
                  height: 26,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "General",
                    style: Styles.manropeExtraBold32.copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'About Wheel N’ Deal',
                  icon: AssetsData.infoIcon,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'FAQ',
                  icon: AssetsData.faqIcon,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'Rate App',
                  icon: AssetsData.rateAppIcon,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'Support',
                  icon: AssetsData.supportIcon,
                ),
                const SizedBox(
                  height: 26,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Legal",
                    style: Styles.manropeExtraBold32.copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'Terms and Conditions',
                  icon: AssetsData.termsIcon,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'Privacy Policy',
                  icon: AssetsData.privacyIcon,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserProfileItem(
                  onTap: () {},
                  text: 'Log Out',
                  icon: AssetsData.logOutIcon,
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
