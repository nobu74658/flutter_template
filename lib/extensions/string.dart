import 'package:flutter/material.dart';

extension ContextExtension on String {
  String get deleteSlash => replaceAll('/', '');

  String get addSlash => this == '/' ? this : '/$this';

  double computeTextHeight(double fontSize, int maxLines, double width) {
    final span = TextSpan(
      text: this,
      style: const TextStyle(
        fontSize: 12,
      ),
    );
    final tp = TextPainter(
      text: span,
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 100);
    return tp.size.height;
  }

  int get dotCount {
    int dotCount = 0;
    for (int i = 0; i < length; i++) {
      if (this[i] == '.') {
        dotCount++;
      }
    }
    return dotCount;
  }
}
