import 'package:json_annotation/json_annotation.dart';
part 'update_user_profile_response.g.dart';

@JsonSerializable()
class UpdateUserProfileResponse {
  String? message;
  @JsonKey(name: 'data')
  UserProfileData? userProfileData;
  int? status;

  UpdateUserProfileResponse({
    this.message,
    this.userProfileData,
    this.status,
  });

  factory UpdateUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileResponseFromJson(json);
}

@JsonSerializable()
class UserProfileData {
  UserProfileData();

  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataFromJson(json);
}
