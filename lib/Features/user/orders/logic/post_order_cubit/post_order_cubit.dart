import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/repos/post_order_repo.dart';
import 'package:wheel_n_deal/Features/user/post_order/logic/post_order_cubit/post_order_state.dart';
import '../../../../../Core/networking/shared_prefs/shared_prefs.dart';

class PostOrderCubit extends Cubit<PostOrderState> {
  final PostOrderRepo _postOrderRepo;
  PostOrderCubit(this._postOrderRepo) : super(const PostOrderState.initial());

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
    emit(const PostOrderState.loading());

    final response = await _postOrderRepo.postOrder(
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
            PostOrderState.error(
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
          emit(PostOrderState.success(postOrderResponse));
        }
      },
      failure: (error) {
        emit(
          PostOrderState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!',
          ),
        );
      },
    );
  }
}
