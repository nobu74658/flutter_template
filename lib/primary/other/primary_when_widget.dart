import 'package:flutter/material.dart';

enum WhenType {
  loading,
  loadingWidget,
  error,
  errorWidget,
}

class PrimaryWhenWidget extends StatelessWidget {
  const PrimaryWhenWidget({
    required this.whenType,
    this.errorMessage,
    super.key,
  });

  final WhenType whenType;
  final Object? errorMessage;

  @override
  Widget build(BuildContext context) {
    switch (whenType) {
      case WhenType.loading:
        return Scaffold(body: _loading());
      case WhenType.loadingWidget:
        return _loading();
      case WhenType.error:
        return Scaffold(
          appBar: AppBar(
            title: const Text('エラーが発生'),
          ),
          body: _error(),
        );
      case WhenType.errorWidget:
        return _error();
    }
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _error() {
    final String message = errorMessage == null
        ? 'エラーが発生しました。\nネットワーク環境をご確認の上、もう一度実行してみて下さい。'
        : errorMessage is ArgumentError
            // ignore: cast_nullable_to_non_nullable
            ? (errorMessage as ArgumentError).message
            : errorMessage.toString();

    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }
}
