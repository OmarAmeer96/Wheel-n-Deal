import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shared_prefs.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/home/presentation/views/widgets/home_features_item.dart';
import 'package:wheel_n_deal/Features/user/home/presentation/views/widgets/user_post_order_item.dart';

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
                        style: Styles.manropeBold32.copyWith(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context)
                              .push(AppRouter.kUserNotificationsView);
                        },
                        child: SvgPicture.asset(
                          AssetsData.noNotificationIcon,
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    "WELCOME ${SharedPrefs.getString(key: 'username')} !",
                    style: Styles.manropeBold32.copyWith(
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
                  style: Styles.manropeSemiBold16.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeFeaturesItem(
                    icon: AssetsData.ordersIcon,
                    text: 'Orders',
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kUserOrdersView);
                    },
                  ),
                  HomeFeaturesItem(
                    icon: AssetsData.favoritesIcon,
                    text: 'Favorite',
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kUserFavouriteView);
                    },
                  ),
                  HomeFeaturesItem(
                    icon: AssetsData.messagesIcon,
                    text: 'Messages',
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kUserMessagesView);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 42,
              ),
              const UserPostOrderItem(),
            ],
          ),
        ),
      ],
    );
  }
}
