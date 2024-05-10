import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wheel_n_deal/Core/networking/api_constants.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/forgot_password_response.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/send_otp_response.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/validate_otp_request_body.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/validate_otp_response.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/models/get_user_profile_response.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/models/login_request_body.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/models/login_response.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/models/signup_request_body.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/models/signup_response.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/post_order_response.dart';
import 'package:wheel_n_deal/Features/user/profile/data/models/update_user_profile_response.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Login
  @POST(ApiConstants.signin)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  // Signup
  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(
    @Body() SignupRequestBody signupRequestBody,
  );

  // Get Profile
  @GET(ApiConstants.getUserProfile)
  Future<GetUserProfileResponse> getProfile(
    @Header('Authorization') String token,
    @Query('id') int id,
  );

  // Forgot Password -----------------------------

  // Send OTP
  @POST(ApiConstants.sendOTP)
  Future<SendOTPResponse> sendOTP(
    @Query('phoneNumber') String phoneNumber,
  );

  // Validate OTP
  @POST(ApiConstants.validateOTP)
  Future<ValidateOTPResponse> validateOTP(
    @Body() ValidateOTPRequestBody validateOTPRequestBody,
  );

  // Forgot Password
  @POST(ApiConstants.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword(
    @Query('phoneNumber') String phoneNumber,
    @Query('newPassword') String newPassword,
  );

  // Update Profile
  @PUT(ApiConstants.updateProfile)
  @MultiPart()
  Future<UpdateUserProfileResponse> updateUserProfile({
    @Header('Authorization') required String token,
    @Part(name: "id") required int id,
    @Part(name: "fullName") String? fullName,
    @Part(name: "gender") String? gender,
    @Part(name: "city") String? city,
    @Part(name: "profilePicture") File? profilePicture,
    @Part(name: "nationalId") String? nationalId,
    @Part(name: "phone") String? phone,
  });

  // Post Order (Create/Update Order)
  @POST(ApiConstants.postOrder)
  @MultiPart()
  Future<PostOrderResponse> postOrder({
    @Header('Authorization') required String token,
    @Part(name: "userId") required int userId,
    @Part(name: "orderName") String? orderName,
    @Part(name: "countOfOrders") int? countOfOrders,
    @Part(name: "weight") int? weight,
    @Part(name: "breakable") String? breakable,
    @Part(name: "expiryDate") String? expiryDate,
    @Part(name: "expectedPrice") double? expectedPrice,
    @Part(name: "orderPhoto") File? orderPhoto,
    @Part(name: "from") String? from,
    @Part(name: "to") String? to,
    @Part(name: "senderName") String? senderName,
    @Part(name: "senderPhoneNumber") String? senderPhoneNumber,
    @Part(name: "receiverName") String? receiverName,
    @Part(name: "receiverPhoneNumber") String? receiverPhoneNumber,
  });
}
