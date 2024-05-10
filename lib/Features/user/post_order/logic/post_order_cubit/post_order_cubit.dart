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
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController senderNameController =
      TextEditingController(text: SharedPrefs.getString(key: kFullName)!);
  // Not Used Yet
  TextEditingController senderPhoneNumberController =
      TextEditingController(text: SharedPrefs.getString(key: kPhone)!);
  TextEditingController receiverPhoneNumberController = TextEditingController();

  // Step 2
  TextEditingController orderNameController = TextEditingController();
  TextEditingController countOfOrdersController = TextEditingController();
  TextEditingController orderWeightController = TextEditingController();
  TextEditingController expectedPriceController = TextEditingController();
  TextEditingController isOrderBreakableController = TextEditingController();
  TextEditingController orderExpiryDateController = TextEditingController();
  File? orderPhoto;

  void emitPostOrderState() async {
    emit(const PostOrderState.loading());
    final response = await _postOrderRepo.postOrder(
      SharedPrefs.getString(key: kToken)!,
      SharedPrefs.getInt(key: kUserId)!,
      orderNameController.text,
      int.parse(countOfOrdersController.text),
      int.parse(orderWeightController.text),
      isOrderBreakableController.text,
      orderExpiryDateController.text,
      double.parse(expectedPriceController.text),
      orderPhoto,
      fromController.text,
      toController.text,
      senderNameController.text,
      receiverPhoneNumberController.text,
    );
    response.when(
      success: (postOrderResponse) async {
        if (postOrderResponse.status != 200) {
          emit(
            PostOrderState.error(
              error: postOrderResponse.message ?? '',
            ),
          );
        } else {
          emit(PostOrderState.success(postOrderResponse));
        }
      },
      failure: (error) {
        emit(PostOrderState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!'));
      },
    );
  }
}
