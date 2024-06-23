import 'package:freezed_annotation/freezed_annotation.dart';
part 'delete_user_not_active_order_state.freezed.dart';

@freezed
class DeleteUserNotActiveOrderState<T> with _$DeleteUserNotActiveOrderState<T> {
  const factory DeleteUserNotActiveOrderState.initial() = _Initial;
  const factory DeleteUserNotActiveOrderState.loading() =
      DeleteUserNotActiveOrderLoading;
  const factory DeleteUserNotActiveOrderState.success(T data) =
      DeleteUserNotActiveOrderSuccess<T>;
  const factory DeleteUserNotActiveOrderState.error({required String error}) =
      DeleteUserNotActiveOrderError;
}
