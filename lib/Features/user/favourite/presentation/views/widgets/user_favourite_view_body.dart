import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';

import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/favourite/presentation/views/widgets/user_favourite_item.dart';

class UserFavouriteViewBody extends StatelessWidget {
  const UserFavouriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Favourite",
        textStyle: Styles.manropeSemiBold16,
        onPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Your Favourite Customers",
                  style: Styles.manropeSemiBold16.copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const UserFavouriteItem(
              commuterName: 'Ali',
              commuterPhoneNumber: '1125127125',
            ),
            const UserFavouriteItem(
              commuterName: 'Ali',
              commuterPhoneNumber: '1125127125',
            ),
            const UserFavouriteItem(
              commuterName: 'Ali',
              commuterPhoneNumber: '1125127125',
            )
          ],
        ),
      ),
    );
  }
}
