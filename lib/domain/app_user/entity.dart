import 'package:app/utils/converter/date_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String userId,
    required String userName,
    required String userIcon,
    @dateTimeToServerTimeConverter DateTime? updatedAt,
  }) = _AppUser;

  const AppUser._();

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  static String get collectionName => 'users';
}
