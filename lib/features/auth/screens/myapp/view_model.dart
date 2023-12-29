import 'package:app/domain/user_auth/repo.dart';
import 'package:app/providers/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class MyAppViewModel extends _$MyAppViewModel {
  UserAuthRepo get userAuthRepo => ref.read(userAuthRepoProvider.notifier);
  FirebaseAuth get auth => ref.read(firebaseAuthProvider);

  @override
  FutureOr<void> build() async {
    final bool isLogin = ref.read(firebaseAuthProvider).currentUser != null;

    await Future.wait([
      Future.delayed(const Duration(milliseconds: 3000)),
      if (isLogin) userAuthRepo.setCurrentUser().catchError((e) => throw e),
    ]);
  }

  Future<void> signOut() async {
    await auth.signOut();
    ref.invalidateSelf();
  }
}
