import 'package:json_annotation/json_annotation.dart';
part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  String? message;
  @JsonKey(name: 'data')
  UserData? userData;
  int? status;

  SignupResponse({
    this.message,
    this.userData,
    this.status,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  String? stripeId;
  int? userId;
  String? token;
  String? refreshToken;

  UserData({
    this.stripeId,
    this.userId,
    this.token,
    this.refreshToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
