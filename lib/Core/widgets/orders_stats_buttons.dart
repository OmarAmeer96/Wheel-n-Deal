import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class OrdersStatsButtons extends StatefulWidget {
  const OrdersStatsButtons({
    super.key,
    required this.widget1,
    required this.widget2,
  });

  final Widget widget1;
  final Widget widget2;

  @override
  OrdersStatsButtonsState createState() => OrdersStatsButtonsState();
}

class OrdersStatsButtonsState extends State<OrdersStatsButtons> {
  bool _isPending = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xff1d272f),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPending = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isPending ? Colors.white : Colors.transparent,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: _isPending ? Colors.black : Colors.white,
                ),
                child: const Text(
                  '  Pending  ',
                  style: Styles.manropeRegular16,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPending = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isPending ? Colors.transparent : Colors.white,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: _isPending ? Colors.white : Colors.black,
                ),
                child: const Text(
                  'Completed',
                  style: Styles.manropeRegular16,
                ),
              ),
            ],
          ),
        ),
        _isPending ? widget.widget1 : widget.widget2,
      ],
    );
  }
}
