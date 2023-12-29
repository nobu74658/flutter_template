import 'package:app/const/urls.dart';
import 'package:app/domain/app_user/entity.dart';
import 'package:app/domain/app_user/provider.dart';
import 'package:app/domain/user_auth/entity.dart';
import 'package:app/domain/user_auth/provider.dart';
import 'package:app/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repo.g.dart';

@riverpod
class UserAuthRepo extends _$UserAuthRepo {
  FirebaseFirestore get db => ref.read(firestoreProvider);

  CollectionReference<UserAuth> get collection =>
      db.collection(UserAuth.collectionName).withConverter<UserAuth>(
            fromFirestore: (snapshot, _) => UserAuth.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson(),
          );

  @override
  void build() {}

  Stream<DocumentSnapshot<UserAuth>> streamUserAuth(String userId) =>
      collection.doc(userId).snapshots();

  Future<void> setCurrentUser() async {
    final User? firebaseUser = ref.read(firebaseAuthProvider).currentUser;
    final String? userId = firebaseUser?.uid;

    if (userId == null) {
      throw ArgumentError('認証エラーが発生しました。\n最初からやり直して下さい');
    }

    await db.runTransaction((t) async {
      /// 最新の userAuth を取得
      final userAuthDocRef = db.collection(UserAuth.collectionName).doc(userId);
      final userAuthDoc =
          await t.get(userAuthDocRef).then((value) => value.data());

      /// 最新の AppUser を取得
      final userDocRef = db.collection(AppUser.collectionName).doc(userId);
      final userDoc = await t.get(userDocRef).then((value) => value.data());

      /// データが無い場合のみアカウントを作成する
      if (userAuthDoc == null && userDoc == null) {
        final UserAuth userAuth = UserAuth(
          userId: userId,
          email: firebaseUser?.email,
        );

        final AppUser user = AppUser(
          userId: userId,
          userName: firebaseUser?.displayName ?? '名無しさん',
          userIcon: firebaseUser?.photoURL ?? Urls.initialIcon,
        );

        t
          ..set(userAuthDocRef, userAuth.toJson())
          ..set(userDocRef, user.toJson());
      }
    }).catchError((e) => throw e);

    /// 成功時はグローバルで currentUser を取得するための provider を発火させる
    await ref.read(currentUserProvider.future);
    await ref.read(currentUserAuthProvider.future);
  }
}
