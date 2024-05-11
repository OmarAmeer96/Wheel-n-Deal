import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_order_state.freezed.dart';

@freezed
class PostOrderState<T> with _$PostOrderState<T> {
  const factory PostOrderState.initial() = _Initial;
  const factory PostOrderState.loading() = Loading;
  const factory PostOrderState.success(T data) = Success<T>;
  const factory PostOrderState.error({required String error}) = Error;
}
