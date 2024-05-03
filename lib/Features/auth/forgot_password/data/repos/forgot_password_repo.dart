import 'package:wheel_n_deal/Core/networking/api_error_handler.dart';
import 'package:wheel_n_deal/Core/networking/api_result.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/forgot_password_response.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/send_otp_response.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/validate_otp_request_body.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/validate_otp_response.dart';

class ForgotPasswordRepo {
  final ApiService _apiServices;

  ForgotPasswordRepo(this._apiServices);

  // Send OTP
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

  // Validate OTP
  Future<ApiResult<ValidateOTPResponse>> validateOTP(
    ValidateOTPRequestBody validateOTPRequestBody,
  ) async {
    try {
      final response = await _apiServices.validateOTP(validateOTPRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  // Forgot Password
  Future<ApiResult<ForgotPasswordResponse>> forgotPasswrod(
    String phoneNumber,
    String newPassword,
  ) async {
    try {
      final response = await _apiServices.forgotPassword(
        phoneNumber,
        newPassword,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
