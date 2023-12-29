import 'dart:async';

import 'package:app/features/auth/screens/sign_up/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class SignUpViewModel extends _$SignUpViewModel {
  @override
  SignUpState build() {
    unawaited(_showBottomSheet());
    return const SignUpState();
  }

  /// 初期処理
  Future<void> _showBottomSheet() async => Future.delayed(
        const Duration(milliseconds: 100),
        () => state = state.copyWith(showBottomSheet: true),
      );
}
