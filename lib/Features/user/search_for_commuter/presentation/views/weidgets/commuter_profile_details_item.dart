import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CommuterProfileDetailsItem extends StatelessWidget {
  const CommuterProfileDetailsItem({
    super.key,
    required this.widget,
    required this.icon,
    required this.text,
  });

  final Widget widget;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1.8,
                color: Color(0x7FFF981A),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                widget,
              ],
            ),
          ),
        ),
        Positioned(
          top: -12.5,
          left: 8,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 18,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    text,
                    style: Styles.manropeRegular15.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
