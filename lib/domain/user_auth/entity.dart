import 'package:app/utils/converter/date_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
abstract class UserAuth with _$UserAuth {
  const factory UserAuth({
    required String userId,
    required String? email,
    @onlyOneDateTimeToServerTimeConverter DateTime? createdAt,
    @dateTimeToServerTimeConverter DateTime? updatedAt,
  }) = _UserAuth;

  const UserAuth._();

  factory UserAuth.fromJson(Map<String, dynamic> json) =>
      _$UserAuthFromJson(json);

  static String get collectionName => 'user_accounts';
}
