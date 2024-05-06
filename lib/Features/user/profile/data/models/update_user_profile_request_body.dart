import 'package:json_annotation/json_annotation.dart';
part 'update_user_profile_request_body.g.dart';

@JsonSerializable()
class UpdateUserProfileRequestBody {
  final int id;
  final String fullName;
  final String gender;
  final String city;
  final String profilePicture;
  final String nationalId;
  final String phone;

  UpdateUserProfileRequestBody({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.city,
    required this.profilePicture,
    required this.nationalId,
    required this.phone,
  });

  Map<String, dynamic> toJson() => _$UpdateUserProfileRequestBodyToJson(this);
}
