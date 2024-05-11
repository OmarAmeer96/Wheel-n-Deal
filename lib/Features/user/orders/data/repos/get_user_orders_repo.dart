import 'package:wheel_n_deal/Core/networking/api_error_handler.dart';
import 'package:wheel_n_deal/Core/networking/api_result.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Features/user/orders/data/models/get_user_orders_response.dart';

class GetUserOrdersRepo {
  final ApiService _apiServices;

  GetUserOrdersRepo(this._apiServices);

  Future<ApiResult<GetUserOrdersResponse>> getUserOrders(
    String token,
    int userId,
  ) async {
    try {
      final response = await _apiServices.getUserOrders(
        token: 'Bearer $token',
        userId: userId,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
