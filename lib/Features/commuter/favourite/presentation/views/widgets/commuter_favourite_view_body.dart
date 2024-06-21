import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/favourite/presentation/views/widgets/commuter_favourite_item.dart';

class CommuterFavouriteViewBody extends StatelessWidget {
  const CommuterFavouriteViewBody({super.key});

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
            const CommuterFavouriteItem(
              customerName: 'Ali',
              customerPhoneNumber: '1125127125',
            ),
            const CommuterFavouriteItem(
              customerName: 'Ali',
              customerPhoneNumber: '1125127125',
            ),
            const CommuterFavouriteItem(
              customerName: 'Ali',
              customerPhoneNumber: '1125127125',
            )
          ],
        ),
      ),
    );
  }
}
