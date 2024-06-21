import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';

class CommuterCompletedOrderDetailsViewBody extends StatefulWidget {
  const CommuterCompletedOrderDetailsViewBody({super.key});

  @override
  State<CommuterCompletedOrderDetailsViewBody> createState() =>
      _CommuterCompletedOrderDetailsViewBodyState();
}

class _CommuterCompletedOrderDetailsViewBodyState
    extends State<CommuterCompletedOrderDetailsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  borderRadius: BorderRadius.circular(500),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
              ),
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
              SizedBox(
                height: Responsive.screenHeight(context) * 0.35,
                child: const GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(31, 41),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
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
                        keyText: 'Sender Phone Number',
                        valText: '01554111002',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Receiver Phone Number',
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Order Details",
                        style: Styles.manropeBold32.copyWith(fontSize: 15),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            CustomReviewSummaryItem(
                              keyText: 'Name   ',
                              valText: 'Camera',
                            ),
                            CustomReviewSummaryItem(
                              keyText: 'Count  ',
                              valText: '2',
                            ),
                            CustomReviewSummaryItem(
                              keyText: 'Weight',
                              valText: '0.5 KG',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  AssetsData.profileImage,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Breakable Order',
                        valText: "Yes",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Expiry Date',
                        valText: '3-5 Dayes',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomReviewSummaryItem(
                        keyText: 'Expected Price',
                        valText: '100 LE',
                      ),
                    ],
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
