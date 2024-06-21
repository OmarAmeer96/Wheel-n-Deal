import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CommuterFavouriteItem extends StatelessWidget {
  const CommuterFavouriteItem({
    super.key,
    required this.customerName,
    required this.customerPhoneNumber,
  });
  final String customerName;
  final String customerPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              AssetsData.profileImage,
              width: 45,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  style: Styles.cairoSemiBold.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '+02 $customerPhoneNumber',
                  style: Styles.cairoRegular.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.kCommuterChatView);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: const Color(0xffe4e4e4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              child: Container(
                // width: 367,
                width: 110,
                height: 36,
                alignment: Alignment.center,
                child: Text(
                  'contact',
                  style: Styles.cairoRegular.copyWith(
                    color: const Color(0xffff981a),
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
