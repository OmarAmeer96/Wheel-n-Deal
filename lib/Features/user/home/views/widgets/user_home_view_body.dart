import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';

class UserHomeViewBody extends StatelessWidget {
  const UserHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: Responsive.screenWidth(context),
          child: Image.asset(
            AssetsData.backGroundImage,
            fit: BoxFit.fill,
          ),
        ),
        const Positioned(
          child: Text("Omar"),
        )
      ],
    );
  }
}
