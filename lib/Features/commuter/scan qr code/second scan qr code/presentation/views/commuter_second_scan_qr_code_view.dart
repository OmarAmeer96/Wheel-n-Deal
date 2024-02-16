import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/scan%20qr%20code/second%20scan%20qr%20code/presentation/views/widgets/commuter_second_scan_qr_code_view_body.dart';

class CommuterSecondScanQrCodeView extends StatelessWidget {
  const CommuterSecondScanQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Scan QR code",
        textStyle: Styles.manropeRegular15.copyWith(
          fontSize: 15,
          color: const Color(0xff191D31),
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const CommuterSecondScanQrCodeViewBody(),
    );
  }
}
