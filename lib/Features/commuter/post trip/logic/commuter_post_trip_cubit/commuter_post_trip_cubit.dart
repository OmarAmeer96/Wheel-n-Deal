import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shared_prefs.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/data/repos/commuter_post_order_repo.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/logic/commuter_post_trip_cubit/commuter_post_trip_state.dart';

class CommuterPostTripCubit extends Cubit<CommuterPostTripState> {
  final CommuterPostTripRepo _commuterPostTripRepo;
  CommuterPostTripCubit(this._commuterPostTripRepo)
      : super(const CommuterPostTripState.initial());

  final formKey = GlobalKey<FormState>();
  // Step 1
  TextEditingController fromController =
      TextEditingController(text: "This is FROM test");
  TextEditingController toController =
      TextEditingController(text: "This is TO test");
  TextEditingController senderNameController =
      TextEditingController(text: SharedPrefs.getString(key: kFullName)!);
  TextEditingController senderPhoneNumberController =
      TextEditingController(text: SharedPrefs.getString(key: kPhone)!);
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverPhoneNumberController = TextEditingController();

  // Step 2
  TextEditingController orderNameController = TextEditingController();
  TextEditingController countOfOrdersController =
      TextEditingController(text: "1");
  TextEditingController orderWeightController = TextEditingController();
  TextEditingController expectedPriceController = TextEditingController();
  TextEditingController orderExpiryDateController =
      TextEditingController(text: "1-2 Days");
  File? orderPhoto;
  bool switchValue = false;

  void emitPostOrderState() async {
    log("OrderPhoto: ${orderPhoto!.path}");
    emit(const CommuterPostTripState.loading());

    final response = await _commuterPostTripRepo.postOrder(
      SharedPrefs.getString(key: kToken)!,
      SharedPrefs.getInt(key: kUserId)!,
      orderNameController.text,
      int.parse(countOfOrdersController.text),
      int.parse(orderWeightController.text),
      switchValue.toString(),
      orderExpiryDateController.text,
      double.parse(expectedPriceController.text),
      orderPhoto,
      fromController.text,
      toController.text,
      senderNameController.text,
      senderPhoneNumberController.text,
      receiverNameController.text,
      receiverPhoneNumberController.text,
    );

    // Save a list of order IDs
    Future<void> saveOrderIds(List<String> orderIds) async {
      await SharedPrefs.setStringList(key: kOrderIds, value: orderIds);
    }

    // Load the list of order IDs
    Future<List<String>> loadOrderIds() async {
      return SharedPrefs.getStringList(key: kOrderIds) ?? [];
    }

    // Add an order ID to the list
    Future<void> addOrderId(String orderId) async {
      List<String> orderIds = await loadOrderIds();
      orderIds.add(orderId);
      await saveOrderIds(orderIds);
    }

    response.when(
      success: (postOrderResponse) async {
        if (postOrderResponse.status != 200) {
          emit(
            CommuterPostTripState.error(
              error: postOrderResponse.message ?? '',
            ),
          );
        } else {
          // Save the order ID to the list
          await addOrderId(
            postOrderResponse.postOrderResponseData!.orderId.toString(),
          );
          log("Order ID: ${postOrderResponse.postOrderResponseData!.orderId}");
          log("Order IDs: ${await loadOrderIds()}");
          emit(CommuterPostTripState.success(postOrderResponse));
        }
      },
      failure: (error) {
        emit(
          CommuterPostTripState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!',
          ),
        );
      },
    );
  }
}
