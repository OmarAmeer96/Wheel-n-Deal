import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class OrdersStatsButtons extends StatelessWidget {
  const OrdersStatsButtons({
    super.key,
    required this.isPending,
    required this.onPendingPressed,
    required this.onCompletedPressed,
  });

  final bool isPending;
  final VoidCallback onPendingPressed;
  final VoidCallback onCompletedPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xff1d272f),
            borderRadius: BorderRadius.circular(50),
            image: const DecorationImage(
              image: AssetImage(AssetsData.ordersButtonsBackground),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onPendingPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isPending ? Colors.white : Colors.transparent,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: isPending ? Colors.black : Colors.white,
                ),
                child: const Text(
                  '    Pending    ',
                  style: Styles.manropeRegular16,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: onCompletedPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isPending ? Colors.transparent : Colors.white,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: isPending ? Colors.white : Colors.black,
                ),
                child: const Text(
                  '  Completed  ',
                  style: Styles.manropeRegular16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
