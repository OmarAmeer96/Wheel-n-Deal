import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wheel_n_deal/Core/networking/api_constants.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/models/get_user_profile_response.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/models/login_request_body.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/models/login_response.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/models/signup_request_body.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/models/signup_response.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.signin)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(
    @Body() SignupRequestBody signupRequestBody,
  );

  @GET(ApiConstants.getUserProfile)
  Future<GetUserProfileResponse> getProfile(
    @Header('Authorization') String token,
    @Query('id') int id,
  );
}