import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/widgets/payment_method_item_container.dart';

class PrevProfitsItem extends StatelessWidget {
  const PrevProfitsItem({
    super.key,
    required this.icon,
    required this.text,
    required this.date,
    required this.price,
  });

  final String icon;
  final String text;
  final String date;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 74,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: const Color(0xFF1D272F).withOpacity(0.2),
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
                  text,
                  style: Styles.manropeRegular15.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  date,
                  style: Styles.cairoRegular.copyWith(
                    color: const Color(0xFFA3A3A3),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "$price  LE",
              style: Styles.manropeRegular15.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
