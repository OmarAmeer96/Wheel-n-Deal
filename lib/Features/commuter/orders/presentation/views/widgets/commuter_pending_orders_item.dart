import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterPendingOrdersItem extends StatelessWidget {
  const CommuterPendingOrdersItem({
    super.key,
    required this.orderStatus,
    required this.orderStatusColor,
    this.onTap,
  });
  final String orderStatus;
  final Color orderStatusColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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
            Text(
              "Order name",
              style: Styles.manropeRegular15.copyWith(
                fontSize: 20,
              ),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.kCommuterFirstScanQrCodeView);
              },
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  AssetsData.ordersScanQrCode,
                  color: kFirstQRCodeColor,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.kCommuterSecondScanQrCodeView);
              },
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  AssetsData.ordersScanQrCode,
                  color: kSecondQRCodeColor,
                ),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: Responsive.screenWidth(context) * 0.21,
              child: Text(
                orderStatus,
                style: Styles.manropeRegular15.copyWith(
                  fontSize: 15,
                  color: orderStatusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
