// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserProfileResponse _$UpdateUserProfileResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserProfileResponse(
      message: json['message'] as String?,
      userProfileData: json['data'] == null
          ? null
          : UserProfileData.fromJson(json['data'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateUserProfileResponseToJson(
        UpdateUserProfileResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.userProfileData,
      'status': instance.status,
    };

UserProfileData _$UserProfileDataFromJson(Map<String, dynamic> json) =>
    UserProfileData();

Map<String, dynamic> _$UserProfileDataToJson(UserProfileData instance) =>
    <String, dynamic>{};
