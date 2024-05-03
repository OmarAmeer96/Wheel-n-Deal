import 'package:wheel_n_deal/Core/networking/api_error_handler.dart';
import 'package:wheel_n_deal/Core/networking/api_result.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/send_otp_response.dart';

class ForgotPasswordRepo {
  final ApiService _apiServices;

  ForgotPasswordRepo(this._apiServices);

  Future<ApiResult<SendOTPResponse>> sendOTP(
    String phoneNumber,
  ) async {
    try {
      final response = await _apiServices.sendOTP(
        phoneNumber,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
