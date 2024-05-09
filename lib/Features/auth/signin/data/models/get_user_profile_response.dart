import 'package:json_annotation/json_annotation.dart';
part 'get_user_profile_response.g.dart';

@JsonSerializable()
class GetUserProfileResponse {
  String? message;
  @JsonKey(name: 'data')
  UserData? userData;
  int? status;

  GetUserProfileResponse({
    this.message,
    this.userData,
    this.status,
  });

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfileResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  String? phoneNumber;
  String? fullName;
  String? profilePhotoURL;
  String? role;
  String? gender;
  String? nationalId;
  String? city;

  UserData({
    this.phoneNumber,
    this.fullName,
    this.profilePhotoURL,
    this.role,
    this.gender,
    this.nationalId,
    this.city,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
