// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EmailAuthState {
  TextEditingController get emailController =>
      throw _privateConstructorUsedError;
  TextEditingController get passController =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get obscureText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmailAuthStateCopyWith<EmailAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailAuthStateCopyWith<$Res> {
  factory $EmailAuthStateCopyWith(
          EmailAuthState value, $Res Function(EmailAuthState) then) =
      _$EmailAuthStateCopyWithImpl<$Res, EmailAuthState>;
  @useResult
  $Res call(
      {TextEditingController emailController,
      TextEditingController passController,
      bool isLoading,
      bool obscureText});
}

/// @nodoc
class _$EmailAuthStateCopyWithImpl<$Res, $Val extends EmailAuthState>
    implements $EmailAuthStateCopyWith<$Res> {
  _$EmailAuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailController = null,
    Object? passController = null,
    Object? isLoading = null,
    Object? obscureText = null,
  }) {
    return _then(_value.copyWith(
      emailController: null == emailController
          ? _value.emailController
          : emailController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      passController: null == passController
          ? _value.passController
          : passController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      obscureText: null == obscureText
          ? _value.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailAuthStateImplCopyWith<$Res>
    implements $EmailAuthStateCopyWith<$Res> {
  factory _$$EmailAuthStateImplCopyWith(_$EmailAuthStateImpl value,
          $Res Function(_$EmailAuthStateImpl) then) =
      __$$EmailAuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController emailController,
      TextEditingController passController,
      bool isLoading,
      bool obscureText});
}

/// @nodoc
class __$$EmailAuthStateImplCopyWithImpl<$Res>
    extends _$EmailAuthStateCopyWithImpl<$Res, _$EmailAuthStateImpl>
    implements _$$EmailAuthStateImplCopyWith<$Res> {
  __$$EmailAuthStateImplCopyWithImpl(
      _$EmailAuthStateImpl _value, $Res Function(_$EmailAuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailController = null,
    Object? passController = null,
    Object? isLoading = null,
    Object? obscureText = null,
  }) {
    return _then(_$EmailAuthStateImpl(
      emailController: null == emailController
          ? _value.emailController
          : emailController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      passController: null == passController
          ? _value.passController
          : passController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      obscureText: null == obscureText
          ? _value.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EmailAuthStateImpl implements _EmailAuthState {
  const _$EmailAuthStateImpl(
      {required this.emailController,
      required this.passController,
      this.isLoading = false,
      this.obscureText = true});

  @override
  final TextEditingController emailController;
  @override
  final TextEditingController passController;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool obscureText;

  @override
  String toString() {
    return 'EmailAuthState(emailController: $emailController, passController: $passController, isLoading: $isLoading, obscureText: $obscureText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailAuthStateImpl &&
            (identical(other.emailController, emailController) ||
                other.emailController == emailController) &&
            (identical(other.passController, passController) ||
                other.passController == passController) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.obscureText, obscureText) ||
                other.obscureText == obscureText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, emailController, passController, isLoading, obscureText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailAuthStateImplCopyWith<_$EmailAuthStateImpl> get copyWith =>
      __$$EmailAuthStateImplCopyWithImpl<_$EmailAuthStateImpl>(
          this, _$identity);
}

abstract class _EmailAuthState implements EmailAuthState {
  const factory _EmailAuthState(
      {required final TextEditingController emailController,
      required final TextEditingController passController,
      final bool isLoading,
      final bool obscureText}) = _$EmailAuthStateImpl;

  @override
  TextEditingController get emailController;
  @override
  TextEditingController get passController;
  @override
  bool get isLoading;
  @override
  bool get obscureText;
  @override
  @JsonKey(ignore: true)
  _$$EmailAuthStateImplCopyWith<_$EmailAuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
