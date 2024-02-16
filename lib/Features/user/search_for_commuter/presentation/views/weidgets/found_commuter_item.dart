import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/widgets/edit_profile_button.dart';
import 'package:wheel_n_deal/constants.dart';

class FoundCommuterItem extends StatelessWidget {
  const FoundCommuterItem({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.from,
    required this.to,
    required this.onPressed,
  });

  final String name;
  final String phoneNumber;
  final String from;
  final String to;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              name,
              style: Styles.cairoSemiBold.copyWith(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              phoneNumber,
              style: Styles.cairoRegular.copyWith(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              "$from - $to",
              style: Styles.cairoRegular.copyWith(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const Spacer(),
        EditProfileButton(
          text: "Contact",
          textColor: kPrimaryColor,
          onPressed: onPressed,
          color: const Color(0xffe4e4e4),
        ),
      ],
    );
  }
}
