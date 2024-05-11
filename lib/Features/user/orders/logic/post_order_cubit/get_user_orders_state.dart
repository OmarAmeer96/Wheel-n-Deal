import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_user_orders_state.freezed.dart';

@freezed
class GetUserOrdersState<T> with _$GetUserOrdersState<T> {
  const factory GetUserOrdersState.initial() = _Initial;
  const factory GetUserOrdersState.loading() = Loading;
  const factory GetUserOrdersState.success(T data) = Success<T>;
  const factory GetUserOrdersState.error({required String error}) = Error;
}
