import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_user_profile_state.freezed.dart';

@freezed
class UpdateUserProfileState<T> with _$UpdateUserProfileState<T> {
  const factory UpdateUserProfileState.initial() = _Initial;
  const factory UpdateUserProfileState.loading() = Loading;
  const factory UpdateUserProfileState.success(T data) = Success<T>;
  const factory UpdateUserProfileState.error({required String error}) = Error;
}
