import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';

import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/widgets/edit_profile_button.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/widgets/commuter_profile_details_item.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/widgets/review_item.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterProfileSeenByTheUserViewBody extends StatefulWidget {
  const CommuterProfileSeenByTheUserViewBody({super.key});

  @override
  State<CommuterProfileSeenByTheUserViewBody> createState() =>
      _CommuterProfileSeenByTheUserViewBodyState();
}

class _CommuterProfileSeenByTheUserViewBodyState
    extends State<CommuterProfileSeenByTheUserViewBody> {
  double weightValue = 10;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: Responsive.screenWidth(context),
                      child: Image.asset(
                        AssetsData.backGroundImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      right: 25,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SizedBox(
                                    height: 64,
                                    child: Image.asset(
                                      AssetsData.profileImage,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -10,
                                    left: 5,
                                    right: 5,
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "4.5",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Spacer(),
                                            SvgPicture.asset(
                                              AssetsData.starIcon,
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Omar",
                                    style: Styles.manropeBold32.copyWith(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Total",
                                            style: Styles.cairoRegular
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            "30 Delivers",
                                            style: Styles.cairoRegular
                                                .copyWith(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Cancel",
                                            style: Styles.cairoRegular
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            "2 Delivers",
                                            style: Styles.cairoRegular
                                                .copyWith(fontSize: 16),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -24,
                      right: 16,
                      child: EditProfileButton(
                        color: kPrimaryColor,
                        text: 'Messaging',
                        textColor: Colors.black,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Details",
                          style: Styles.manropeExtraBold18,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommuterProfileDetailsItem(
                        icon: AssetsData.phoneIcon,
                        text: "Phone Number",
                        widget: Row(
                          children: [
                            Text(
                              "+20 1554111002",
                              style: Styles.manropeRegular15.copyWith(
                                letterSpacing: 4.42,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, right: 16),
                              child: SizedBox(
                                width: Responsive.screenWidth(context) * 0.92,
                                child: CommuterProfileDetailsItem(
                                  icon: AssetsData.locationIcon,
                                  text: "Trip Details",
                                  widget: Container(
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Address",
                                          style: Styles.manropeBold32
                                              .copyWith(fontSize: 15),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: [
                                              CustomReviewSummaryItem(
                                                keyText: 'From',
                                                valText:
                                                    'Port-said mohammed ali St',
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
                                          "Trip Details",
                                          style: Styles.manropeBold32
                                              .copyWith(fontSize: 15),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: [
                                              CustomReviewSummaryItem(
                                                keyText: 'Day          ',
                                                valText: 'Monday',
                                              ),
                                              CustomReviewSummaryItem(
                                                keyText: 'Start at',
                                                valText: '9 AM',
                                              ),
                                              CustomReviewSummaryItem(
                                                keyText: 'End at    ',
                                                valText: '1 PM',
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const CustomReviewSummaryItem(
                                              keyText: 'Capacity',
                                              valText: '',
                                            ),
                                            Slider(
                                              thumbColor: Colors.deepOrange,
                                              inactiveColor:
                                                  const Color(0xffa4a4a4),
                                              activeColor: kPrimaryColor,
                                              min: 0,
                                              max: 20,
                                              value: weightValue,
                                              onChanged: (double value) {
                                                setState(() {
                                                  weightValue = value;
                                                });
                                              },
                                            ),
                                            Text(
                                              '${weightValue.toStringAsFixed(0)} kg',
                                              style: Styles.manropeRegular15
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Reviews",
                          style: Styles.manropeExtraBold18,
                        ),
                      ),
                      SizedBox(
                        height: 190,
                        width: double.infinity,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return const Padding(
                              padding: EdgeInsets.only(
                                top: 16,
                              ),
                              child: SizedBox(
                                child: ReviewItem(
                                  image: AssetsData.profileImage,
                                  name: "Omar",
                                  rating: 4,
                                  review:
                                      "Honest and fast, will definitely deal with him again.",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 76,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 16,
            right: 16,
            child: CustomMainButton(
              onPressed: () {
                context.pushNamed(Routes.kChooseCommuterButNoOrderYetView);
              },
              color: kPrimaryColor,
              text: "Choose",
            ),
          ),
        ],
      ),
    );
  }
}
