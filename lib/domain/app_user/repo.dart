import 'package:app/const/error_message.dart';
import 'package:app/domain/app_user/entity.dart';
import 'package:app/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repo.g.dart';

@riverpod
class AppUserRepo extends _$AppUserRepo {
  FirebaseFirestore get db => ref.read(firestoreProvider);

  CollectionReference<AppUser> get collection =>
      db.collection(AppUser.collectionName).withConverter<AppUser>(
            fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson(),
          );

  @override
  void build() {}

  Stream<DocumentSnapshot<AppUser>> streamUser(String userId) =>
      collection.doc(userId).snapshots();

  Future<AppUser> fetchUserById(String userId) async =>
      collection.doc(userId).get().then((value) {
        if (value.data() == null) {
          throw EM.primaryError;
        }
        return value.data()!;
      });
}
