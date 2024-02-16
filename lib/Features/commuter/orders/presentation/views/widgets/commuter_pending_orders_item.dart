import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterPendingOrdersItem extends StatelessWidget {
  final String orderStatus;
  final Color orderStatusColor;
  const CommuterPendingOrdersItem(
      {super.key, required this.orderStatus, required this.orderStatusColor});

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
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kCommuterFirstScanQrCodeView);
          },
          icon: const Icon(
            Icons.qr_code_scanner_rounded,
            size: 27,
            color: kFirstQRCodeColor,
          ),
        ),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kCommuterSecondScanQrCodeView);
          },
          icon: const Icon(
            Icons.qr_code_scanner_rounded,
            size: 27,
            color: kSecondQRCodeColor,
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
    );
  }
}
