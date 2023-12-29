import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// dateTimeデータが null の時のみサーバー時間を入力する
/// 1回しかデータを入れない場合に使用してください。
/// 推奨：createdAt
///
/// 注意：扱うデータは必ず null許容 である必要がある
///
/// {
///   1回目
///   createdAt: null → ServerTimestamp
///
///   2回目以降
///   createdAt: 最初に追加された ServerTimestamp が残り続ける
/// }
const onlyOneDateTimeToServerTimeConverter =
    DateTimeTimestampConverter(isOnlyOne: true);

/// データが入っていない場合のみサーバー時間を挿入する
/// 注意：扱うデータは必ず null許容 である必要がある
///
/// 例）下記では createdAt のみに ServerTime が入る
///
/// {
///   createdAt: null → ServerTimestamp
///   updatedAt: DateTime(1990) → 1990/01/01
/// }
const dateTimeToServerTimeConverter =
    DateTimeTimestampConverter(isServerTimestamp: true);

/// データが入ってる場合のみ DateTime を追加する
/// ServerTime は一切扱わない
/// 注意：扱うデータは必ず null許容 である必要がある
///
/// 例）下記では openAt のみに DateTime が入る
///
/// {
///   openAt: DateTime(2023) → 2023/01/01
///   endAt: null → null
/// }
const normalDateTimeConverter = DateTimeTimestampConverter();

/// 「送信時・取得時」共に nullを許容しない
/// required DateTime 型を使用する場合
/// openAt・endAt などで使用
///
/// {
///   openAt: DateTime(2023, 1, 1),
///   endAt: DateTime(2024, 3, 24),
/// }
const requiredDateTimeConverter = RequiredDateTimeConverter();

class DateTimeTimestampConverter implements JsonConverter<DateTime?, Object?> {
  const DateTimeTimestampConverter({
    this.isServerTimestamp = false,
    this.isOnlyOne = false,
  });

  final bool isServerTimestamp;
  final bool isOnlyOne;

  @override
  DateTime? fromJson(Object? json) => json is Timestamp ? json.toDate() : null;

  @override
  Object? toJson(DateTime? dateTime) => isOnlyOne
      ? dateTime ?? FieldValue.serverTimestamp()
      : isServerTimestamp
          ? FieldValue.serverTimestamp()
          : dateTime;
}

class RequiredDateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const RequiredDateTimeConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}
