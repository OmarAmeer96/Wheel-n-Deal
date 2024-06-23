import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';

import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/user/orders/data/models/get_user_orders_response.dart';
import 'package:wheel_n_deal/Features/user/orders/logic/post_order_cubit/get_user_orders_cubit.dart';
import 'package:wheel_n_deal/Features/user/orders/logic/post_order_cubit/get_user_orders_state.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/custom_review_summary_item.dart';
import 'package:wheel_n_deal/constants.dart';

class UserOrderDetailsViewBody extends StatefulWidget {
  final GetUserOrdersResponseData? userOrder;
  const UserOrderDetailsViewBody({
    super.key,
    this.userOrder,
  });

  @override
  State<UserOrderDetailsViewBody> createState() =>
      _UserOrderDetailsViewBodyState();
}

class _UserOrderDetailsViewBodyState extends State<UserOrderDetailsViewBody> {
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    context.read<GetUserOrdersCubit>().emitGetUserOrdersState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userOrder == null) {
      return const Scaffold(
        body: Center(
          child: Text('No order found'),
        ),
      );
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: BlocBuilder<GetUserOrdersCubit, GetUserOrdersState>(
                builder: (context, state) {
                  return Column(
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
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: QrImageView(
                              data: widget.userOrder!.senderCode.toString(),
                              size: 170,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              AssetsData.qrTopRight,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: SvgPicture.asset(
                              AssetsData.qrTopLeft,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              AssetsData.qrBottomRight,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: SvgPicture.asset(
                              AssetsData.qrBottomLeft,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
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
                              CustomReviewSummaryItem(
                                keyText: 'Sender Name',
                                valText:
                                    widget.userOrder!.senderName.toString(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomReviewSummaryItem(
                                keyText: 'Sender Phone Number',
                                valText: widget.userOrder!.senderPhoneNumber
                                    .toString(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomReviewSummaryItem(
                                keyText: 'Receiver Phone Number',
                                valText: widget.userOrder!.receiverPhoneNumber
                                    .toString(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Address",
                                style:
                                    Styles.manropeBold32.copyWith(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    CustomReviewSummaryItem(
                                      keyText: 'From',
                                      valText:
                                          widget.userOrder!.from.toString(),
                                    ),
                                    CustomReviewSummaryItem(
                                      keyText: 'To      ',
                                      valText: widget.userOrder!.to.toString(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Order Details",
                                style:
                                    Styles.manropeBold32.copyWith(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    CustomReviewSummaryItem(
                                      keyText: 'Name   ',
                                      valText: widget.userOrder!.orderName
                                          .toString(),
                                    ),
                                    CustomReviewSummaryItem(
                                      keyText: 'Count  ',
                                      valText: widget.userOrder!.countOfOrders
                                          .toString(),
                                    ),
                                    CustomReviewSummaryItem(
                                      keyText: 'Weight',
                                      valText:
                                          widget.userOrder!.weight.toString(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: widget.userOrder!
                                                      .orderPhotoUrl !=
                                                  null
                                              ? ClipOval(
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: widget.userOrder!
                                                        .orderPhotoUrl!,
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                )
                                              : const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: AssetImage(
                                                    AssetsData.profileImage,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomReviewSummaryItem(
                                keyText: 'Breakable Order',
                                valText: widget.userOrder!.breakable.toString(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomReviewSummaryItem(
                                keyText: 'Expiry Date',
                                valText:
                                    widget.userOrder!.expiryDate.toString(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomReviewSummaryItem(
                                keyText: 'Expected Price',
                                valText:
                                    widget.userOrder!.expectedPrice.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 85,
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: CustomMainButton(
                text: "Cancel the order",
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Warning before cancellation",
                                      style: Styles.manropeRegular15.copyWith(
                                        color: kPrimaryColor,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Warning before cancellation: If the cancellation occurs after the start of delivery, 20% of the agreed upon value of money will be deducted.",
                                      style: Styles.manropeRegular15.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 60,
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
                                          context.pushNamed(
                                            Routes.kUserCanceledOrderView,
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
                                          context.pop();
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
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
