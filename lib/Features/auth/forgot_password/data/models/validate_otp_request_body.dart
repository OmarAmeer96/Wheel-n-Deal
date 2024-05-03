import 'package:json_annotation/json_annotation.dart';
part 'validate_otp_request_body.g.dart';

@JsonSerializable()
class ValidateOTPRequestBody {
  final String otpNumber;
  final String phoneNumber;

  ValidateOTPRequestBody({
    required this.otpNumber,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => _$ValidateOTPRequestBodyToJson(this);
}
