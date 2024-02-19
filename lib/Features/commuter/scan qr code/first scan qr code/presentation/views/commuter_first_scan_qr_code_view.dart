import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/scan%20qr%20code/first%20scan%20qr%20code/presentation/views/widgets/commuter_first_scan_qr_code_view_body.dart';

class CommuterFirstScanQrCodeView extends StatelessWidget {
  const CommuterFirstScanQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Scan QR code",
        textStyle: Styles.manropeRegular15.copyWith(
          fontSize: 18,
          color: const Color(0xff191D31),
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const CommuterFirstScanQrCodeViewBody(),
    );
  }
}
