import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/widgets/payment_method_item_container.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
  });

  final String icon;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 74,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFF1D272F),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            PaymentMethodItemContainer(icon: icon),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: Styles.manropeRegular16,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  text2,
                  style: Styles.cairoRegular.copyWith(
                    color: const Color(0xFFA3A3A3),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
