import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
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
        items: const <Widget>[
          NavBarItem(
            text: "Home",
            icon: AssetsData.homeIcon,
          ),
          NavBarItem(
            text: "Search",
            icon: AssetsData.searchIcon,
          ),
          NavBarItem(
            text: "Others",
            icon: AssetsData.othersIcon,
          ),
          NavBarItem(
            text: "Profile",
            icon: AssetsData.profileIcon,
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
      body:

          // Container(
          //   color: Colors.blueAccent,
          //   child: Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Text(page.toString(), textScaleFactor: 10.0),
          //         ElevatedButton(
          //           child: const Text('Go To Page of index 1'),
          //           onPressed: () {
          //             final CurvedNavigationBarState? navBarState =
          //                 _bottomNavigationKey.currentState;
          //             navBarState?.setPage(1);
          //           },
          //         )
          //       ],
          //     ),
          //   ),
          // ),

          const UserHomeViewBody(),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          // ignore: deprecated_member_use
          color: Colors.white,
          width: 22,
        ),
        Text(
          text,
          style: Styles.poppinsSemiBold16.copyWith(
            color: Colors.white,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
