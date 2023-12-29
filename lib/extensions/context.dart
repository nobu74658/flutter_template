import 'dart:async';

import 'package:app/primary/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ContextExtension on BuildContext {
  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get bottomSafeArea => MediaQuery.of(this).padding.bottom;
  double get topSafeArea => MediaQuery.of(this).padding.top;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  TextStyle get titleStyle => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get subtitleStyle => Theme.of(this).textTheme.titleMedium!;
  TextStyle get bodyStyle => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get smallStyle => Theme.of(this).textTheme.bodySmall!;
  TextStyle get verySmallStyle =>
      Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: 10);
  bool get isIphoneMiniSize =>
      deviceWidth == 320 && deviceHeight == 568; // iPhone SE 1st
  double get appBarHeight => MediaQuery.of(this).padding.top + kToolbarHeight;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  /// エラー処理
  Future<void> error({
    Object? message,
    bool needVibration = false,
  }) async {
    if (needVibration) {
      unawaited(HapticFeedback.vibrate());
    }

    ScaffoldMessenger.of(this)
        .showSnackBar(SnackBar(content: Text(_convertErrorMessage(message))));
  }

  Future<void> errorDialog(Object? e) async {
    SD.oneChoiceAlert(
      context: this,
      titleText: 'エラー',
      contentText: _convertErrorMessage(e),
    );
  }
}

String _convertErrorMessage(Object? error) => error is ArgumentError
    ? error.message
    : error != null
        ? error.toString()
        : '不明なエラーです\nWifi環境をお確かめの上、もう一度実行して下さい';
