import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class UserFavouriteItem extends StatelessWidget {
  const UserFavouriteItem({
    super.key,
    required this.commuterName,
    required this.commuterPhoneNumber,
  });
  final String commuterName;
  final String commuterPhoneNumber;

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
                  commuterName,
                  style: Styles.cairoSemiBold.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '+02 $commuterPhoneNumber',
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
                GoRouter.of(context).push(AppRouter.kUserChatView);
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
