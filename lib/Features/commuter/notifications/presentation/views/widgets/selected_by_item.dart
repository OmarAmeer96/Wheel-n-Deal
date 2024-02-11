import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class SelectedByItem extends StatelessWidget {
  const SelectedByItem({
    super.key,
    required this.name,
    required this.phoneNumber,
  });

  final String name;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 65,
          child: Image.asset(
            AssetsData.profileImage,
          ),
        ),
        const SizedBox(
          width: 17,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Styles.cairoSemiBold.copyWith(
                color: Colors.black,
              ),
            ),
            Text(
              phoneNumber,
              style: Styles.cairoSemiBold.copyWith(
                color: Colors.black,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
