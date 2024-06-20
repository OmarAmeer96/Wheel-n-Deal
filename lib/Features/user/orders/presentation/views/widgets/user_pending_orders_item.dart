import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/orders/data/models/get_user_orders_response.dart';
import 'package:wheel_n_deal/constants.dart';

class UserPendingOrdersItem extends StatelessWidget {
  const UserPendingOrdersItem({
    super.key,
    required this.onTap,
    required this.userOrder,
  });

  final void Function()? onTap;
  final GetUserOrdersResponseData userOrder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 12,
        ),
        child: Row(
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
            Expanded(
              child: SizedBox(
                width: 100,
                child: Text(
                  userOrder.orderName ?? "Order Name",
                  style: Styles.manropeRegular15.copyWith(
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Text(
              userOrder.orderStatus ?? "Order Status",
              style: Styles.manropeRegular15.copyWith(
                fontSize: 15,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
