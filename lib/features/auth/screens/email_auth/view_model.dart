import 'package:app/domain/user_auth/repo.dart';
import 'package:app/features/auth/screens/email_auth/handling_firebase_auth.dart';
import 'package:app/features/auth/screens/email_auth/state.dart';
import 'package:app/providers/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class EmailAuthViewModel extends _$EmailAuthViewModel {
  FirebaseAuth get auth => ref.read(firebaseAuthProvider);
  UserAuthRepo get userAuthRepo => ref.read(userAuthRepoProvider.notifier);

  @override
  EmailAuthState build() => EmailAuthState(
        emailController: TextEditingController(),
        passController: TextEditingController(),
      );

  /// obscureText 更新
  void updateObscureText() =>
      state = state.copyWith(obscureText: !state.obscureText);

  /// 認証処理
  Future<void> signInWithEmailAndPassword() async {
    final String email = state.emailController.text.trim();
    final String password = state.passController.text.trim();

    try {
      _updateLoading(true);

      /// メール認証
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await userAuthRepo.setCurrentUser();
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException エラー内容: $e');
      throw handleFirebaseAuthError(e.code);
    } on Exception catch (e) {
      debugPrint('FirebaseAuth UnKnown Error: $e');
      throw ArgumentError('不明なエラーが発生しました');
    } finally {
      _updateLoading(false);
    }
  }

  /// Loading 更新
  void _updateLoading(bool isLoading) =>
      state = state.copyWith(isLoading: isLoading);
}
