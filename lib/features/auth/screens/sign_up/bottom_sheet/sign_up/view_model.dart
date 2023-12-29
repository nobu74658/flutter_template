import 'package:app/domain/user_auth/repo.dart';
import 'package:app/features/auth/screens/sign_up/bottom_sheet/sign_up/components/sign_up_type_bottom.dart';
import 'package:app/providers/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'view_model.g.dart';

@riverpod
class SignUpBottomSheetViewModel extends _$SignUpBottomSheetViewModel {
  UserAuthRepo get userAuthRepo => ref.read(userAuthRepoProvider.notifier);

  @override
  void build() {}

  /// sns 認証
  Future<void> signUp(SignUpType signUpType) async {
    switch (signUpType) {
      case SignUpType.google:
        await _signInWithGoogle().catchError((e) => throw e);
      case SignUpType.apple:
        await _signInWithApple().catchError((e) => throw e);
      case SignUpType.email:
        break;
    }
  }

  /// Google Sign In
  Future<void> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? signInAccount = await googleSignIn.signIn();

      if (signInAccount == null) {
        throw ArgumentError('不明なエラーが発生しました\nアプリをもう一度起動させてから行ってください');
      }

      final GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken,
      );

      await ref.read(firebaseAuthProvider).signInWithCredential(credential);
      await userAuthRepo.setCurrentUser();
    } on Exception {
      rethrow;
    }
  }

  /// Apple Sign In
  Future<void> _signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await ref.read(firebaseAuthProvider).signInWithCredential(credential);
      await userAuthRepo.setCurrentUser();
    } on Exception {
      rethrow;
    }
  }
}
