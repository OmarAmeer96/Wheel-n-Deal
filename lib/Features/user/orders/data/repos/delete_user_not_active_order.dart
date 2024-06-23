import 'package:wheel_n_deal/Core/networking/api_error_handler.dart';
import 'package:wheel_n_deal/Core/networking/api_result.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';

class DeleteUserNotActiveOrderRepo {
  final ApiService _apiServices;

  DeleteUserNotActiveOrderRepo(this._apiServices);

  Future<ApiResult<void>> deleteNotActiveOrder(
    String token,
    int orderId,
  ) async {
    try {
      final response = await _apiServices.deleteNotActiveOrder(
        token: 'Bearer $token',
        orderId: orderId,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
