import 'package:wheel_n_deal/Core/networking/api_error_handler.dart';
import 'package:wheel_n_deal/Core/networking/api_result.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/models/signup_request_body.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/models/signup_response.dart';

class SignupRepo {
  final ApiService _apiServices;

  SignupRepo(this._apiServices);

  Future<ApiResult<SignupResponse>> signup(
      SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiServices.signup(signupRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
