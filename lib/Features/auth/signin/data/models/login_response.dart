import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? message;
  @JsonKey(name: 'data')
  UserData? userData;
  int? status;

  LoginResponse({
    this.message,
    this.userData,
    this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  String? role;
  String? stripeId;
  int? userId;
  String? token;
  String? refreshToken;

  UserData({
    this.role,
    this.stripeId,
    this.userId,
    this.token,
    this.refreshToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
