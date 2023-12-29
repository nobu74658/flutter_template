import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class EmailAuthState with _$EmailAuthState {
  const factory EmailAuthState({
    required TextEditingController emailController,
    required TextEditingController passController,
    @Default(false) bool isLoading,
    @Default(true) bool obscureText,
  }) = _EmailAuthState;
}
