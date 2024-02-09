import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
    required this.time,
    this.onTap,
  });

  final String icon;
  final String text1;
  final String text2;
  final String time;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: ShapeDecoration(
                  color: const Color(0xFF1D272F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: SvgPicture.asset(icon),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            text1,
                            style: Styles.manropeRegular14.copyWith(
                              color: const Color(0xFF191D31),
                              fontSize: 16,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        Text(
                          time,
                          style: Styles.manropeRegular14.copyWith(
                            color: const Color(0xFFA3A3A3),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      text2,
                      style: Styles.manropeRegular14.copyWith(
                        color: const Color(0xFFA3A3A3),
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          color: Color(0xFFF3F3F3),
          thickness: 2,
        ),
      ],
    );
  }
}
