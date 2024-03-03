import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/widgets/contact_item.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterPickOrderDetailsViewBdy extends StatefulWidget {
  const CommuterPickOrderDetailsViewBdy({super.key});

  @override
  State<CommuterPickOrderDetailsViewBdy> createState() =>
      _CommuterPickOrderDetailsViewBdyState();
}

class _CommuterPickOrderDetailsViewBdyState
    extends State<CommuterPickOrderDetailsViewBdy> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.79900787528476, 31.00206213176501),
      zoom: 13,
    );
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;
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
                    style: Styles.manropeBold32.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      googleMapController = controller;
                      initMapStyle();
                    },
                    initialCameraPosition: initialCameraPosition,
                    mapType: MapType.normal,
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
                        const Row(
                          children: [
                            CustomReviewSummaryItem(
                              keyText: 'Sender Name',
                              valText: 'Omar',
                            ),
                            Spacer(),
                            ContactItem(
                              icon: AssetsData.phoneIcon,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ContactItem(
                              icon: AssetsData.messagesIcon,
                            ),
                          ],
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
                          style: Styles.manropeBold32.copyWith(fontSize: 15),
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
                    text: "Pick",
                    onPressed: () {
                      GoRouter.of(context)
                          .push(AppRouter.kCommuterOrderPickedView);
                    },
                    color: kPrimaryColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainButton(
                    text: "Set another expected price",
                    textColor: Colors.black,
                    borderSideColor: Colors.black,
                    onPressed: () {
                      GoRouter.of(context)
                          .push(AppRouter.kSetAnotherExpectedPriceView);
                    },
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

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    // ignore: deprecated_member_use
    googleMapController.setMapStyle(nightMapStyle);
  }
}
