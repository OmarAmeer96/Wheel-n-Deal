import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/home/views/widgets/home_features_item.dart';

class UserHomeViewBody extends StatelessWidget {
  const UserHomeViewBody({super.key});

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
              top: 50,
              left: 25,
              right: 25,
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsData.mainLogoIcon,
                        width: 50,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Wheel N’ Deal",
                        style: Styles.manropeExtraBold32.copyWith(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        AssetsData.yesNotificationIcon,
                        width: 25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    "WELCOME!",
                    style: Styles.manropeExtraBold32.copyWith(
                      fontSize: 25,
                      color: Colors.white,
                    ),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeFeaturesItem(
                    icon: AssetsData.ordersIcon,
                    text: 'Orders',
                  ),
                  HomeFeaturesItem(
                    icon: AssetsData.favoritesIcon,
                    text: 'Favorite',
                  ),
                  HomeFeaturesItem(
                    icon: AssetsData.messagesIcon,
                    text: 'Messages',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
