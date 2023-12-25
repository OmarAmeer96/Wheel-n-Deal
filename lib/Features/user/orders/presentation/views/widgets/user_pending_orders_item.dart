import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class UserPendingOrdersItem extends StatelessWidget {
  const UserPendingOrdersItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsData.ordersIcon,
          // ignore: deprecated_member_use
          color: Colors.black,
          width: 24,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          "Order name",
          style: Styles.manropeRegular15.copyWith(
            fontSize: 20,
          ),
        ),
        const Spacer(),
        Text(
          "pending",
          style: Styles.manropeRegular15.copyWith(
            fontSize: 15,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
