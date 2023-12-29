import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

class PrimaryWhenErrorWidget extends StatelessWidget {
  const PrimaryWhenErrorWidget(
    this.error, {
    super.key,
    this.isScreen = true,
  });

  final bool isScreen;
  final Object error;

  @override
  Widget build(BuildContext context) {
    if (isScreen) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('エラーが発生'),
        ),
        body: _error(),
      );
    }

    return _error();
  }

  Widget _error() {
    final String message = error is ArgumentError
        // ignore: cast_nullable_to_non_nullable
        ? (error as ArgumentError).message
        : error.toString();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
