import 'package:json_annotation/json_annotation.dart';
part 'send_otp_response.g.dart';

@JsonSerializable()
class SendOTPResponse {
  String? message;
  @JsonKey(name: 'data')
  OTPData? otpData;
  int? status;

  SendOTPResponse({
    this.message,
    this.otpData,
    this.status,
  });

  factory SendOTPResponse.fromJson(Map<String, dynamic> json) =>
      _$SendOTPResponseFromJson(json);
}

@JsonSerializable()
class OTPData {
  String? status;
  String? message;

  OTPData({
    this.status,
    this.message,
  });

  factory OTPData.fromJson(Map<String, dynamic> json) =>
      _$OTPDataFromJson(json);
}
