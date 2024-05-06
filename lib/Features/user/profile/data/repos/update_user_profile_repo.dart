import 'dart:io';

import 'package:wheel_n_deal/Core/networking/api_error_handler.dart';
import 'package:wheel_n_deal/Core/networking/api_result.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Features/user/profile/data/models/update_user_profile_response.dart';

class UpdateUserProfileRepo {
  final ApiService _apiServices;

  UpdateUserProfileRepo(this._apiServices);

  Future<ApiResult<UpdateUserProfileResponse>> updateUserProfile(
    String token,
    int id,
    String fullName,
    String gender,
    String city,
    File profilePicture,
    String nationalId,
    String phone,
  ) async {
    try {
      final response = await _apiServices.updateUserProfile(
        'Bearer $token',
        id,
        fullName,
        gender,
        city,
        profilePicture,
        nationalId,
        phone,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
