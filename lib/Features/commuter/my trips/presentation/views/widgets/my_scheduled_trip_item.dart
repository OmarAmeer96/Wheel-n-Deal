import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/views/widgets/my_scheduled_trips_row.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/views/widgets/show_delete_confirmation_dialog.dart';
import 'package:wheel_n_deal/constants.dart';

class MyScheduledTripsItem extends StatelessWidget {
  const MyScheduledTripsItem({
    super.key,
    this.formattedTime,
  });

  final String? formattedTime;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            color: const Color(0x7FA3A3A3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: Styles.manropeBold32.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      MyScheduledTripsRow(
                        keyText: 'From',
                        valText: 'Port-said mohammed ali St',
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      MyScheduledTripsRow(
                        keyText: 'To',
                        valText: 'Tanta',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Trip Details",
                  style: Styles.manropeBold32.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      const MyScheduledTripsRow(
                        keyText: 'Day',
                        valText: 'Monday',
                      ),
                      const SizedBox(height: 6),
                      MyScheduledTripsRow(
                        keyText: 'Start at',
                        valText: formattedTime!,
                      ),
                      const SizedBox(height: 6),
                      MyScheduledTripsRow(
                        keyText: 'End at',
                        valText: formattedTime!,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const MyScheduledTripsRow(
                  keyText: 'Capacity',
                  valText: "3 kg",
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Column(
            children: [
              SizedBox(
                width: Responsive.screenWidth(context) * 0.3,
                height: Responsive.screenHeight(context) * 0.04,
                child: CustomMainButton(
                  text: "Edit Trip",
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kCommuterPostTripView);
                  },
                  color: const Color(0x66A4A4A4),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                  width: Responsive.screenWidth(context) * 0.3,
                  height: Responsive.screenHeight(context) * 0.04,
                  child: CustomMainButton(
                      text: "Delete",
                      onPressed: () {
                        showDeleteConfirmationDialog(context);
                      },
                      color: kPrimaryColor))
            ],
          ),
        ),
      ],
    );
  }
}
