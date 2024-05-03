import 'package:json_annotation/json_annotation.dart';
part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  String? message;
  @JsonKey(name: 'data')
  ForgotPasswordData? forgotPasswordData;
  int? status;

  ForgotPasswordResponse({
    this.message,
    this.forgotPasswordData,
    this.status,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@JsonSerializable()
class ForgotPasswordData {
  ForgotPasswordData();

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordDataFromJson(json);
}
