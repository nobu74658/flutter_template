import 'package:app/domain/user_auth/entity.dart';
import 'package:app/domain/user_auth/repo.dart';
import 'package:app/providers/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
Stream<UserAuth> currentUserAuth(CurrentUserAuthRef ref) async* {
  final String? userId = ref.read(firebaseAuthProvider).currentUser?.uid;

  if (userId == null) {
    throw ArgumentError('userId is null');
  }

  final UserAuthRepo userAuthRepo = ref.read(userAuthRepoProvider.notifier);

  await for (final doc in userAuthRepo.streamUserAuth(userId)) {
    if (doc.data() != null) {
      yield doc.data()!;
    }
  }
}
