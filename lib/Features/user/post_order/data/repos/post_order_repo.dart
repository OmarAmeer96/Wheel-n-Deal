import 'dart:io';

import 'package:wheel_n_deal/Core/networking/api_error_handler.dart';
import 'package:wheel_n_deal/Core/networking/api_result.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/post_order_response.dart';

class PostOrderRepo {
  final ApiService _apiServices;

  PostOrderRepo(this._apiServices);

  Future<ApiResult<PostOrderResponse>> postOrder(
    String token,
    int userId,
    String orderName,
    int countOfOrders,
    int weight,
    String breakable,
    String expiryDate,
    double expectedPrice,
    File? orderPhoto,
    String from,
    String to,
    String senderName,
    String receiverPhoneNumber,
  ) async {
    try {
      final response = await _apiServices.postOrder(
        token: 'Bearer $token',
        userId: userId,
        orderName: orderName,
        countOfOrders: countOfOrders,
        weight: weight,
        breakable: breakable,
        expiryDate: expiryDate,
        expectedPrice: expectedPrice,
        orderPhoto: orderPhoto,
        from: from,
        to: to,
        senderName: senderName,
        receiverPhoneNumber: receiverPhoneNumber,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
