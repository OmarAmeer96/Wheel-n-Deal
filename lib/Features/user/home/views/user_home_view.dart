import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Features/user/home/views/widgets/user_home_view_body.dart';
import 'package:wheel_n_deal/constants.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  int page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          SvgPicture.asset(
            AssetsData.homeIcon,
            // ignore: deprecated_member_use
            color: Colors.white,
            width: 26,
          ),
          SvgPicture.asset(
            AssetsData.searchIcon,
            // ignore: deprecated_member_use
            color: Colors.white,
            width: 26,
          ),
          SvgPicture.asset(
            AssetsData.othersIcon,
            // ignore: deprecated_member_use
            color: Colors.white,
            width: 26,
          ),
          SvgPicture.asset(
            AssetsData.profileIcon,
            // ignore: deprecated_member_use
            color: Colors.white,
            width: 26,
          ),
        ],
        color: const Color(0xFF1D272F),
        buttonBackgroundColor: kPrimaryColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: const UserHomeViewBody(),
    );
  }
}
