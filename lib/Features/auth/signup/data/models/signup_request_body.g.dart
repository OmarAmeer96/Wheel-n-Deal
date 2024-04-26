// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequestBody _$SignupRequestBodyFromJson(Map<String, dynamic> json) =>
    SignupRequestBody(
      username: json['username'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      confirmPassword: json['confirmPassword'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$SignupRequestBodyToJson(SignupRequestBody instance) =>
    <String, dynamic>{
      'username': instance.username,
      'phone': instance.phone,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'role': instance.role,
    };
