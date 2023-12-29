import 'package:app/domain/app_user/entity.dart';
import 'package:app/domain/app_user/repo.dart';
import 'package:app/providers/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
Stream<AppUser> currentUser(CurrentUserRef ref) async* {
  final String? userId = ref.read(firebaseAuthProvider).currentUser?.uid;

  if (userId == null) {
    throw ArgumentError('userId is null');
  }

  final AppUserRepo userRepo = ref.read(appUserRepoProvider.notifier);

  await for (final doc in userRepo.streamUser(userId)) {
    if (doc.data() != null) {
      yield doc.data()!;
    }
  }
}
