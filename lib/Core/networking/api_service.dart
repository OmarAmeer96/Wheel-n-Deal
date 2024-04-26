import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wheel_n_deal/Core/networking/api_constants.dart';
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
}
