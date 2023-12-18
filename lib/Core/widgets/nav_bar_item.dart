import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

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
