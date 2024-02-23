import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterOrderDetailsViewBody extends StatelessWidget {
  const CommuterOrderDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Review Summary",
                    style: Styles.manropeExtraBold32.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(31, 41),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: const Color(0x7FA3A3A3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomReviewSummaryItem(
                          keyText: 'Sender Name',
                          valText: 'Omar',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomReviewSummaryItem(
                          keyText: 'Phone Number',
                          valText: '01554111002',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Address",
                          style:
                              Styles.manropeExtraBold32.copyWith(fontSize: 15),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              CustomReviewSummaryItem(
                                keyText: 'From',
                                valText: 'Port-said mohammed ali St',
                              ),
                              CustomReviewSummaryItem(
                                keyText: 'To      ',
                                valText: 'Tanta',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 140,
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CustomMainButton(
                    text: "Start Delivey",
                    onPressed: () {},
                    color: kPrimaryColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainButton(
                    text: "Cancel",
                    textColor: Colors.black,
                    borderSideColor: Colors.black,
                    onPressed: () {},
                    color: const Color(0xfff3f3f3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
