// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_user_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GetUserOrdersState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(UserOrdersLoading<T> value) loading,
    required TResult Function(UserOrdersFetched<T> value) success,
    required TResult Function(UserOrdersError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(UserOrdersLoading<T> value)? loading,
    TResult? Function(UserOrdersFetched<T> value)? success,
    TResult? Function(UserOrdersError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(UserOrdersLoading<T> value)? loading,
    TResult Function(UserOrdersFetched<T> value)? success,
    TResult Function(UserOrdersError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetUserOrdersStateCopyWith<T, $Res> {
  factory $GetUserOrdersStateCopyWith(GetUserOrdersState<T> value,
          $Res Function(GetUserOrdersState<T>) then) =
      _$GetUserOrdersStateCopyWithImpl<T, $Res, GetUserOrdersState<T>>;
}

/// @nodoc
class _$GetUserOrdersStateCopyWithImpl<T, $Res,
        $Val extends GetUserOrdersState<T>>
    implements $GetUserOrdersStateCopyWith<T, $Res> {
  _$GetUserOrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<T, $Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl<T> value, $Res Function(_$InitialImpl<T>) then) =
      __$$InitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<T, $Res>
    extends _$GetUserOrdersStateCopyWithImpl<T, $Res, _$InitialImpl<T>>
    implements _$$InitialImplCopyWith<T, $Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl<T> _value, $Res Function(_$InitialImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl<T> implements _Initial<T> {
  const _$InitialImpl();

  @override
  String toString() {
    return 'GetUserOrdersState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(UserOrdersLoading<T> value) loading,
    required TResult Function(UserOrdersFetched<T> value) success,
    required TResult Function(UserOrdersError<T> value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(UserOrdersLoading<T> value)? loading,
    TResult? Function(UserOrdersFetched<T> value)? success,
    TResult? Function(UserOrdersError<T> value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(UserOrdersLoading<T> value)? loading,
    TResult Function(UserOrdersFetched<T> value)? success,
    TResult Function(UserOrdersError<T> value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial<T> implements GetUserOrdersState<T> {
  const factory _Initial() = _$InitialImpl<T>;
}

/// @nodoc
abstract class _$$UserOrdersLoadingImplCopyWith<T, $Res> {
  factory _$$UserOrdersLoadingImplCopyWith(_$UserOrdersLoadingImpl<T> value,
          $Res Function(_$UserOrdersLoadingImpl<T>) then) =
      __$$UserOrdersLoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UserOrdersLoadingImplCopyWithImpl<T, $Res>
    extends _$GetUserOrdersStateCopyWithImpl<T, $Res,
        _$UserOrdersLoadingImpl<T>>
    implements _$$UserOrdersLoadingImplCopyWith<T, $Res> {
  __$$UserOrdersLoadingImplCopyWithImpl(_$UserOrdersLoadingImpl<T> _value,
      $Res Function(_$UserOrdersLoadingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UserOrdersLoadingImpl<T> implements UserOrdersLoading<T> {
  const _$UserOrdersLoadingImpl();

  @override
  String toString() {
    return 'GetUserOrdersState<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserOrdersLoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(UserOrdersLoading<T> value) loading,
    required TResult Function(UserOrdersFetched<T> value) success,
    required TResult Function(UserOrdersError<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(UserOrdersLoading<T> value)? loading,
    TResult? Function(UserOrdersFetched<T> value)? success,
    TResult? Function(UserOrdersError<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(UserOrdersLoading<T> value)? loading,
    TResult Function(UserOrdersFetched<T> value)? success,
    TResult Function(UserOrdersError<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UserOrdersLoading<T> implements GetUserOrdersState<T> {
  const factory UserOrdersLoading() = _$UserOrdersLoadingImpl<T>;
}

/// @nodoc
abstract class _$$UserOrdersFetchedImplCopyWith<T, $Res> {
  factory _$$UserOrdersFetchedImplCopyWith(_$UserOrdersFetchedImpl<T> value,
          $Res Function(_$UserOrdersFetchedImpl<T>) then) =
      __$$UserOrdersFetchedImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$UserOrdersFetchedImplCopyWithImpl<T, $Res>
    extends _$GetUserOrdersStateCopyWithImpl<T, $Res,
        _$UserOrdersFetchedImpl<T>>
    implements _$$UserOrdersFetchedImplCopyWith<T, $Res> {
  __$$UserOrdersFetchedImplCopyWithImpl(_$UserOrdersFetchedImpl<T> _value,
      $Res Function(_$UserOrdersFetchedImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$UserOrdersFetchedImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$UserOrdersFetchedImpl<T> implements UserOrdersFetched<T> {
  const _$UserOrdersFetchedImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'GetUserOrdersState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserOrdersFetchedImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserOrdersFetchedImplCopyWith<T, _$UserOrdersFetchedImpl<T>>
      get copyWith =>
          __$$UserOrdersFetchedImplCopyWithImpl<T, _$UserOrdersFetchedImpl<T>>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(UserOrdersLoading<T> value) loading,
    required TResult Function(UserOrdersFetched<T> value) success,
    required TResult Function(UserOrdersError<T> value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(UserOrdersLoading<T> value)? loading,
    TResult? Function(UserOrdersFetched<T> value)? success,
    TResult? Function(UserOrdersError<T> value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(UserOrdersLoading<T> value)? loading,
    TResult Function(UserOrdersFetched<T> value)? success,
    TResult Function(UserOrdersError<T> value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class UserOrdersFetched<T> implements GetUserOrdersState<T> {
  const factory UserOrdersFetched(final T data) = _$UserOrdersFetchedImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$UserOrdersFetchedImplCopyWith<T, _$UserOrdersFetchedImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserOrdersErrorImplCopyWith<T, $Res> {
  factory _$$UserOrdersErrorImplCopyWith(_$UserOrdersErrorImpl<T> value,
          $Res Function(_$UserOrdersErrorImpl<T>) then) =
      __$$UserOrdersErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$UserOrdersErrorImplCopyWithImpl<T, $Res>
    extends _$GetUserOrdersStateCopyWithImpl<T, $Res, _$UserOrdersErrorImpl<T>>
    implements _$$UserOrdersErrorImplCopyWith<T, $Res> {
  __$$UserOrdersErrorImplCopyWithImpl(_$UserOrdersErrorImpl<T> _value,
      $Res Function(_$UserOrdersErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$UserOrdersErrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserOrdersErrorImpl<T> implements UserOrdersError<T> {
  const _$UserOrdersErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'GetUserOrdersState<$T>.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserOrdersErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserOrdersErrorImplCopyWith<T, _$UserOrdersErrorImpl<T>> get copyWith =>
      __$$UserOrdersErrorImplCopyWithImpl<T, _$UserOrdersErrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(UserOrdersLoading<T> value) loading,
    required TResult Function(UserOrdersFetched<T> value) success,
    required TResult Function(UserOrdersError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(UserOrdersLoading<T> value)? loading,
    TResult? Function(UserOrdersFetched<T> value)? success,
    TResult? Function(UserOrdersError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(UserOrdersLoading<T> value)? loading,
    TResult Function(UserOrdersFetched<T> value)? success,
    TResult Function(UserOrdersError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UserOrdersError<T> implements GetUserOrdersState<T> {
  const factory UserOrdersError({required final String error}) =
      _$UserOrdersErrorImpl<T>;

  String get error;
  @JsonKey(ignore: true)
  _$$UserOrdersErrorImplCopyWith<T, _$UserOrdersErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
