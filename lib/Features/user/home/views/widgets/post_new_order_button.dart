import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/constants.dart';

class PostNewOrderButton extends StatelessWidget {
  const PostNewOrderButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

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
        width: 25,
        height: 38,
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
