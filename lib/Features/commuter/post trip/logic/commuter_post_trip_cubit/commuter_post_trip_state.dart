import 'package:freezed_annotation/freezed_annotation.dart';
part 'commuter_post_trip_state.freezed.dart';

@freezed
class CommuterPostTripState<T> with _$CommuterPostTripState<T> {
  const factory CommuterPostTripState.initial() = _Initial;
  const factory CommuterPostTripState.loading() = Loading;
  const factory CommuterPostTripState.success(T data) = Success<T>;
  const factory CommuterPostTripState.error({required String error}) = Error;
}
