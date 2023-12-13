import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';

class FadingLogo extends StatelessWidget {
  const FadingLogo({
    super.key,
    required this.opacityAnimation,
  });

  final Animation<double> opacityAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnimation,
      builder: (context, _) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Image.asset(
              AssetsData.splashLogoPng3,
              height: 310,
            ),
          ),
          // Another Image:

          // Image.asset(
          //   AssetsData.splashLogoPng2,
          //   height: 310,
          // ),
        );
      },
    );
  }
}
