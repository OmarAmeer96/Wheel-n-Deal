import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            const SizedBox(
              width: 20,
            ),
            Stack(children: [
              const CircleAvatar(
                radius: 24, // Adjust the radius as needed
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  AssetsData.profileImage,
                ),
              ),
              Positioned(
                left: 34,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF1D272F),
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1.50,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ahmed",
                  style: Styles.manropeMedium18.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF151B33)),
                ),
                Text(
                  "Online",
                  style: Styles.manropeRegular14
                      .copyWith(color: const Color(0xFFA7AEC1)),
                )
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                color: Color(0xFFA3A3A3),
                size: 40,
              ),
            ),
          ],
        ),
        const Divider(thickness: 1, color: Color(0xFFA3A3A3))
      ],
    );
  }
}
