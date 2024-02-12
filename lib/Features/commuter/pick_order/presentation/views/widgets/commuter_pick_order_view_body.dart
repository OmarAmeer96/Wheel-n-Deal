import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/widgets/commuter_pick_order_text_field.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/widgets/edit_profile_button.dart';

class CommuterPickOrderViewBody extends StatelessWidget {
  const CommuterPickOrderViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pick Order',
                  style: Styles.manropeRegular16.copyWith(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "From",
                style: Styles.manropeRegular15.copyWith(
                  fontSize: 18,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const CommuterPickOrderTextField(),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "To",
                style: Styles.manropeRegular15.copyWith(
                  fontSize: 18,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const CommuterPickOrderTextField(),
            const SizedBox(
              height: 18,
            ),
            const Divider(
              color: Color(0xFFF3F3F3),
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
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
                EditProfileButton(
                  text: "View Details",
                  onPressed: () {
                    GoRouter.of(context)
                        .push(AppRouter.kCommuterOrderDetailesView);
                  },
                  color: const Color(0x4CA3A3A3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
