import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Features/commuter/home/presentation/views/widgets/commuter_home_view_body.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/widgets/commuter_orders_view_body.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/widgets/commuter_pick_order_view_body.dart';
import '../../../../../Core/utils/assets.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../../../constants.dart';
import '../../../profile/presentation/views/widgets/commuter_profile_view_body.dart';

class CommuterHomeView extends StatefulWidget {
  const CommuterHomeView({super.key});

  @override
  State<CommuterHomeView> createState() => _CommuterHomeViewState();
}

class _CommuterHomeViewState extends State<CommuterHomeView> {
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
        return const CommuterHomeViewBody();
      case 1:
        return const CommuterPickOrderViewBody();
      case 2:
        return const CommuterOrdersViewBody();
      case 3:
        return const CommuterProfileViewBody();
      default:
        return Container();
    }
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
