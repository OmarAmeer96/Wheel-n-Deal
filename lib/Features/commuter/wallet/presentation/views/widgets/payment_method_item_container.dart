import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethodItemContainer extends StatelessWidget {
  const PaymentMethodItemContainer({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F3F3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: 30,
        ),
      ),
    );
  }
}
