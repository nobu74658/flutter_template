import 'package:flutter/foundation.dart';

class EM {
  static Error primaryError = ArgumentError(
    'ネットワーク環境とURLをご確認の上\nもう一度実行して下さい。\n'
    '${kIsWeb ? 'また、WEB版をご使用の場合は複数のタブで\nご利用出来ませんのでご注意ください' : ''}',
  );

  static Error urlError =
      ArgumentError('URLに誤りがあるみたいです。\n再度ご確認の上、もう一度実行して下さい。');

  static Error netWorkError =
      ArgumentError('エラーが発生しました。\nネットワーク環境をお確かめの上\nもう一度実行して下さい。');

  static Error unKnownError =
      ArgumentError('不明なエラーが発生しました\n${EM.primaryError}');

  static Error photoAccessDenied =
      ArgumentError('写真フォルダのアクセスがありません\n権限を変更してもう一度実行してください。');

  static Error invalidPhoto =
      ArgumentError('無効な画像です\n別の写真を選択するか、もう一度実行してみてください。');
}
