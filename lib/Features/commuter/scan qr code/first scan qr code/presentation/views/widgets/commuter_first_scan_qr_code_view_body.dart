import 'package:flutter/material.dart';
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
  // String _scanResult = '';

  // @override
  // void initState() {
  //   super.initState();
  // }

  // Future<void> scanCode() async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         "#ff6666", "cancel", true, ScanMode.QR);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to scan';
  //   }
  //   setState(() {
  //     _scanResult = barcodeScanRes;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8, left: 21.15, right: 20.89, bottom: 91),
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
              style: Styles.manropeExtraBold32
                  .copyWith(color: const Color(0xff191D31), fontSize: 20),
            ),
          ),
          const SizedBox(height: 300.43),
          CustomMainButton(
            onPressed: () {
              // scanCode();
            },
            color: kPrimaryColor,
            contentIsText: false,
            widget: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
              ),
              const SizedBox(
                width: 11.39,
              ),
              Text(
                "Scan QR Code",
                style: Styles.manropeMedium18
                    .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
              )
            ]),
          )
        ],
      ),
    );
  }
}
