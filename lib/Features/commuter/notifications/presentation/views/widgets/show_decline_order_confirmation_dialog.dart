import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/views/widgets/trip_deleted_confirmation_button.dart';
import 'package:wheel_n_deal/constants.dart';

void showDeclineOrderConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        title: Text(
          "Are you sure to decline the order",
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
                    context.pop();
                  },
                  color: kPrimaryColor,
                ),
                TripDeletedConfirmationButton(
                  borderSideColor: Colors.black,
                  text: 'Yes',
                  textColor: const Color(0xFF1D272F),
                  onPressed: () {
                    context.pushNamed(Routes.kHomeView);
                  },
                  color: const Color(0xfff3f3f3),
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
