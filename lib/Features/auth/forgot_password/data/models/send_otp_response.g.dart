// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOTPResponse _$SendOTPResponseFromJson(Map<String, dynamic> json) =>
    SendOTPResponse(
      message: json['message'] as String?,
      otpData: json['data'] == null
          ? null
          : OTPData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$SendOTPResponseToJson(SendOTPResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.otpData,
      'status': instance.status,
    };

OTPData _$OTPDataFromJson(Map<String, dynamic> json) => OTPData(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$OTPDataToJson(OTPData instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
