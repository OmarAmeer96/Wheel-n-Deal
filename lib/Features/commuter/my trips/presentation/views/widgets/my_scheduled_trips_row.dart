import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/views/widgets/custom_scheduled_trips_text.dart';

class MyScheduledTripsRow extends StatelessWidget {
  const MyScheduledTripsRow(
      {super.key, required this.keyText, required this.valText});
  final String keyText;
  final String valText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomScheduledTripsText(
          text: '$keyText: ',
        ),
        const SizedBox(width: 73),
        CustomScheduledTripsText(
          text: valText,
        ),
      ],
    );
  }
}
