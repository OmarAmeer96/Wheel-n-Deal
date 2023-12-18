import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/constants.dart';

class PostPickOrdersButton extends StatelessWidget {
  const PostPickOrdersButton(
      {super.key, required this.onTap, this.width = 25, this.height = 38});

  final Function() onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: SvgPicture.asset(
            AssetsData.plusIcon,
            width: 25,
          ),
        ),
      ),
    );
  }
}
