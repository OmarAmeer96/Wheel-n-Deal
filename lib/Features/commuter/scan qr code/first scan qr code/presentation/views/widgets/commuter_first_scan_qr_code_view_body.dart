import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterFirstScanQrCodeViewBody extends StatefulWidget {
  const CommuterFirstScanQrCodeViewBody({super.key});

  @override
  State<CommuterFirstScanQrCodeViewBody> createState() =>
      _CommuterFirstScanQrCodeViewBodyState();
}

class _CommuterFirstScanQrCodeViewBodyState
    extends State<CommuterFirstScanQrCodeViewBody> {
      String qrResult = "Scanned Data Will Appear Here";
  Future<void> scanQr() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      setState(() {
        qrResult = qrCode.toString();
      });
    } on PlatformException {
      qrResult = "Failed to Read the Code :(";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 26),
          const Divider(
            color: Color(0xFFF3F3F3),
            thickness: 2,
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Scan Package QR Code",
              style: Styles.manropeExtraBold32.copyWith(
                color: const Color(0xff191D31),
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 300.43),
          CustomMainButton(
            onPressed: () {
              log("Omario");
            },
            color: kPrimaryColor,
            contentIsText: false,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsData.ordersScanQrCode,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 11.39,
                ),
                Text(
                  "Scan QR Code",
                  style: Styles.manropeMedium18.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
