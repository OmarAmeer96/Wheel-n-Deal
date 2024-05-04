import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shared_prefs.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/widgets/nav_bar_item.dart';
import 'package:wheel_n_deal/Features/commuter/home/presentation/views/widgets/commuter_home_view_body.dart';
import 'package:wheel_n_deal/Features/user/home/presentation/views/widgets/user_home_view_body.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_orders_view_body.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/widgets/user_profile_view_body.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/user_search_for_commuter_view_body.dart';
import 'package:wheel_n_deal/constants.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const NavBarItem(
        text: "Home",
        icon: AssetsData.homeIcon,
      ),
      const NavBarItem(
        text: "Search",
        icon: AssetsData.searchIcon,
      ),
      const NavBarItem(
        text: "Orders",
        icon: AssetsData.ordersIcon2,
      ),
      const NavBarItem(
        text: "Profile",
        icon: AssetsData.profileIcon,
      ),
    ];
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        // Design
        height: 55.0,
        color: const Color(0xFF1D272F),
        buttonBackgroundColor: kPrimaryColor,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 200),

        // Impo
        items: items,
        index: index,
        onTap: (index) => setState(() => this.index = index),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (index) {
      case 0:
        return SharedPrefs.getString(key: kRole) == "USER"
            ? const UserHomeViewBody()
            : const CommuterHomeViewBody();
      case 1:
        return const UserSearchForCommuterViewBody();
      case 2:
        return const UserOrdersViewBody();
      case 3:
        return const UserProfileViewBody();
      default:
        return Container();
    }
  }
}
