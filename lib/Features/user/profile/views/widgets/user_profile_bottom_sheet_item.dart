import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class UserProfileBottomSheetItem extends StatelessWidget {
  const UserProfileBottomSheetItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final String icon;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: 343,
        height: 54,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0x1E191D31),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            SvgPicture.asset(
              icon,
              width: 22,
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              text,
              style: Styles.cairoSemiBold.copyWith(
                color: const Color(0xFF191D31),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
