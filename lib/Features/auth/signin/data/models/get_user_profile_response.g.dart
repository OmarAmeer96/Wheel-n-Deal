// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserProfileResponse _$GetUserProfileResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserProfileResponse(
      message: json['message'] as String?,
      userData: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetUserProfileResponseToJson(
        GetUserProfileResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.userData,
      'status': instance.status,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      phoneNumber: json['phoneNumber'] as String?,
      fullName: json['fullName'] as String?,
      profilePhotoURL: json['profilePhotoURL'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'profilePhotoURL': instance.profilePhotoURL,
      'role': instance.role,
    };
