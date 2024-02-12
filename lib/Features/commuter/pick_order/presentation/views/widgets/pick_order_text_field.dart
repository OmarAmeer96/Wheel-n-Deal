import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class PickOrderTextField extends StatelessWidget {
  const PickOrderTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: ShapeDecoration(
        color: const Color(0xCCA3A3A3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 4,
            right: 16,
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  AssetsData.searchIcon,
                  color: const Color(0xFF191D31),
                ),
              ),
              border: InputBorder.none,
              hintText: 'Enter Location..',
              hintStyle: Styles.cairoSemiBold.copyWith(
                color: const Color(0xFF191D31),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: Styles.cairoSemiBold.copyWith(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
