import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterPendingOrderDetailsViewBody extends StatefulWidget {
  const CommuterPendingOrderDetailsViewBody({super.key});

  @override
  State<CommuterPendingOrderDetailsViewBody> createState() =>
      _CommuterPendingOrderDetailsViewBodyState();
}

class _CommuterPendingOrderDetailsViewBodyState
    extends State<CommuterPendingOrderDetailsViewBody> {
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
                    text: "Start Delivey",
                    onPressed: () {
                      GoRouter.of(context)
                          .push(AppRouter.kCommuterStartedDeliveyView);
                    },
                    color: kPrimaryColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainButton(
                    text: "Cancel",
                    textColor: Colors.black,
                    borderSideColor: Colors.black,
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 60,
                                    height: 6,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFA3A3A3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Warning before cancellation",
                                          style:
                                              Styles.manropeRegular15.copyWith(
                                            color: kPrimaryColor,
                                            fontSize: 22,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "If the cancellation is less than 4 hours before delivery, this will reduce the number of successful trips for you.",
                                          style:
                                              Styles.manropeRegular15.copyWith(
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "If you have already received the order from the customer, you will have to return the order to the customer again, and this will reduce the number of successful trips for you.",
                                          style:
                                              Styles.manropeRegular15.copyWith(
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Are you sure?",
                                    style: Styles.manropeRegular15.copyWith(
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomMainButton(
                                            height: 25,
                                            onPressed: () {
                                              GoRouter.of(context).push(
                                                AppRouter
                                                    .kCommuterCanceledOrderView,
                                              );
                                            },
                                            text: "Yes",
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: CustomMainButton(
                                            height: 25,
                                            onPressed: () {
                                              GoRouter.of(context).pop();
                                            },
                                            text: "No",
                                            textColor: Colors.black,
                                            borderSideColor: Colors.black,
                                            color: const Color(0xfff3f3f3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
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
