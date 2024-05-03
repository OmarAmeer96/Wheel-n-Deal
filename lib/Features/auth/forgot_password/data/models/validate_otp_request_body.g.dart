// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_otp_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateOTPRequestBody _$ValidateOTPRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ValidateOTPRequestBody(
      otpNumber: json['otpNumber'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$ValidateOTPRequestBodyToJson(
        ValidateOTPRequestBody instance) =>
    <String, dynamic>{
      'otpNumber': instance.otpNumber,
      'phoneNumber': instance.phoneNumber,
    };
