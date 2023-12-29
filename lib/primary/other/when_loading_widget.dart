import 'package:flutter/material.dart';

class PrimaryWhenLoadingWidget extends StatelessWidget {
  const PrimaryWhenLoadingWidget({
    this.isScreen = true,
    super.key,
  });

  final bool isScreen;

  @override
  Widget build(BuildContext context) {
    if (isScreen) {
      return Scaffold(body: _loading());
    }

    return _loading();
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());
}
