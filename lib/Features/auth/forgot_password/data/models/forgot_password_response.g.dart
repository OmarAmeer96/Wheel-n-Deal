// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      message: json['message'] as String?,
      forgotPasswordData: json['data'] == null
          ? null
          : ForgotPasswordData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.forgotPasswordData,
      'status': instance.status,
    };

ForgotPasswordData _$ForgotPasswordDataFromJson(Map<String, dynamic> json) =>
    ForgotPasswordData();

Map<String, dynamic> _$ForgotPasswordDataToJson(ForgotPasswordData instance) =>
    <String, dynamic>{};
