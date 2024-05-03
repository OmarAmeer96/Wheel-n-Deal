import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shared_prefs.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/auth/signin/logic/login_cubit/login_cubit.dart';
import 'package:wheel_n_deal/Features/auth/signin/logic/login_cubit/login_state.dart';
import '../../../../../../Core/utils/assets.dart';
import '../../../../../../Core/utils/responsive.dart';
import '../../../../../user/home/presentation/views/widgets/home_features_item.dart';
import 'commuter_order_items.dart';

class CommuterHomeViewBody extends StatefulWidget {
  const CommuterHomeViewBody({super.key});

  @override
  State<CommuterHomeViewBody> createState() => _CommuterHomeViewBodyState();
}

class _CommuterHomeViewBodyState extends State<CommuterHomeViewBody> {
  @override
  void initState() {
    context.read<LoginCubit>().emitGetUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is Success) {
          context.read<LoginCubit>().emitGetUserProfile();
        }
      },
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
                                .push(AppRouter.kCommuterNotificationsView);
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
                      "WELCOME ${SharedPrefs.getString(key: kUsername)} !",
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
                        GoRouter.of(context)
                            .push(AppRouter.kCommuterOrdersView);
                      },
                    ),
                    HomeFeaturesItem(
                      icon: AssetsData.favoritesIcon,
                      text: 'Favorite',
                      onTap: () {
                        GoRouter.of(context)
                            .push(AppRouter.kCommuterFavouriteView);
                      },
                    ),
                    HomeFeaturesItem(
                      icon: AssetsData.messagesIcon,
                      text: 'Messages',
                      onTap: () {
                        GoRouter.of(context)
                            .push(AppRouter.kCommuterMessagesView);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeFeaturesItem(
                      icon: AssetsData.ordersIcon,
                      text: 'My Trips',
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kMyTripsView);
                      },
                    ),
                    HomeFeaturesItem(
                      icon: AssetsData.favoritesIcon,
                      text: 'Reviews',
                      onTap: () {
                        GoRouter.of(context)
                            .push(AppRouter.kCommuterReviewsView);
                      },
                    ),
                    HomeFeaturesItem(
                      icon: AssetsData.messagesIcon,
                      text: 'Wallet',
                      onTap: () {
                        GoRouter.of(context)
                            .push(AppRouter.kCommuterWalletView);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 42,
                ),
                const CommuterItems(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
