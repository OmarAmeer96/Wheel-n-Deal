// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserProfileRequestBody _$UpdateUserProfileRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateUserProfileRequestBody(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      gender: json['gender'] as String,
      city: json['city'] as String,
      profilePicture: json['profilePicture'] as String,
      nationalId: json['nationalId'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UpdateUserProfileRequestBodyToJson(
        UpdateUserProfileRequestBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'city': instance.city,
      'profilePicture': instance.profilePicture,
      'nationalId': instance.nationalId,
      'phone': instance.phone,
    };
