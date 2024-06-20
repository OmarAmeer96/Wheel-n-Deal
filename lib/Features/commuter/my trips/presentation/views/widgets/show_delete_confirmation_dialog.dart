import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/views/widgets/trip_deleted_confirmation_button.dart';
import 'package:wheel_n_deal/constants.dart';

void showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        title: Text(
          "Are you sure to delete this trip?",
          style: Styles.manropeRegular15.copyWith(fontSize: 19),
        ),
        actions: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TripDeletedConfirmationButton(
                  text: 'No',
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  color: kPrimaryColor,
                ),
                TripDeletedConfirmationButton(
                  text: 'Yes',
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kTripDeletedView);
                  },
                  color: const Color(0xFF1D272F),
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
