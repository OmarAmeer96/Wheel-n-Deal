import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/support/presentation/views/widgets/custom_support_view_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class SupportViewBody extends StatelessWidget {
  const SupportViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        // Messages Here
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomSupportViewAppBar(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  child: Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 52,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF3F3F3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your message..',
                                hintStyle: Styles.cairoSemiBold.copyWith(
                                  color: const Color(0xFF191D31),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
