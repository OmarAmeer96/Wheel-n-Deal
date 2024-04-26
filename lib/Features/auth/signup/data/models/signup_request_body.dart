import 'package:json_annotation/json_annotation.dart';
part 'signup_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  final String username;
  final String phone;
  final String password;
  final String confirmPassword;
  final String role;

  SignupRequestBody({
    required this.username,
    required this.password,
    required this.phone,
    required this.confirmPassword,
    required this.role,
  });

  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}
