import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class UserProfileItem extends StatelessWidget {
  const UserProfileItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1.3,
              color: Color(0x7FFF981A),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              icon,
              width: 20,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              text,
              style: Styles.poppinsSemiBold16.copyWith(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
