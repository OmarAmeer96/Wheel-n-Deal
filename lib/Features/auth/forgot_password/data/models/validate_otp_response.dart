import 'package:json_annotation/json_annotation.dart';
part 'validate_otp_response.g.dart';

@JsonSerializable()
class ValidateOTPResponse {
  String? message;
  @JsonKey(name: 'data')
  OTPData? otpData;
  int? status;

  ValidateOTPResponse({
    this.message,
    this.otpData,
    this.status,
  });

  factory ValidateOTPResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidateOTPResponseFromJson(json);
}

@JsonSerializable()
class OTPData {
  String? stripeId;
  int? userId;
  String? token;
  String? refreshToken;

  OTPData({
    this.stripeId,
    this.userId,
    this.token,
    this.refreshToken,
  });

  factory OTPData.fromJson(Map<String, dynamic> json) =>
      _$OTPDataFromJson(json);
}
