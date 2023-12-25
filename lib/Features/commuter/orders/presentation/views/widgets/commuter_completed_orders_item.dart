import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CommuterCompletedOrdersItem extends StatelessWidget {
  const CommuterCompletedOrdersItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order name",
              style: Styles.manropeRegular15.copyWith(
                fontSize: 20,
              ),
            ),
            Text(
              "90 LE",
              style: Styles.manropeRegular15.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "Success",
          style: Styles.manropeRegular15.copyWith(
            fontSize: 15,
            color: const Color(0xFF2CA19A),
          ),
        ),
      ],
    );
  }
}
