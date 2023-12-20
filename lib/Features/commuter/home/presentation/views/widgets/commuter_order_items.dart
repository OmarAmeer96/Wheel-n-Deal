import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import '../../../../../../Core/widgets/post_pick_orders_button.dart';

class CommuterItems extends StatelessWidget {
  const CommuterItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.screenWidth(context),
      height: 130,
      decoration: ShapeDecoration(
        color: const Color(0xFF1D272F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Post a New Trip',
                  style: Styles.manropeRegular16.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                PostPickOrdersButton(
                  width: 30,
                  height: 27,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Pick a New Order',
                  style: Styles.manropeRegular16.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                PostPickOrdersButton(
                  width: 30,
                  height: 27,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}