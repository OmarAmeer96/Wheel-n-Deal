import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/views/widgets/my_scheduled_trip_item.dart';

class MyTripsViewBody extends StatelessWidget {
  const MyTripsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();

    String formattedTime = DateFormat('h    a').format(time);
    return Scaffold(
      appBar:
          buildAppBar(text: "My Trips", textStyle: Styles.manropeSemiBold16),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            const SizedBox(
              height: 23,
            ),
            Row(
              children: [
                Text(
                  "My Scheduled Trips",
                  style: Styles.manropeBold32.copyWith(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 23,
            ),
            MyScheduledTripsItem(formattedTime: formattedTime),
            const SizedBox(
              height: 30,
            ),
            MyScheduledTripsItem(formattedTime: formattedTime),
            const SizedBox(
              height: 30,
            ),
            MyScheduledTripsItem(formattedTime: formattedTime),
            const SizedBox(
              height: 30,
            ),
            MyScheduledTripsItem(formattedTime: formattedTime),
            const SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }
}
