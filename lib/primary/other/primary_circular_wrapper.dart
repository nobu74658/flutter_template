import 'package:app/extensions/context.dart';
import 'package:flutter/material.dart';

class PrimaryCircularWrapper extends StatelessWidget {
  const PrimaryCircularWrapper({
    required this.child,
    required this.isLoading,
    super.key,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,

          /// サーキュラー
          if (isLoading)
            Container(
              width: context.deviceWidth,
              height: context.deviceHeight,
              color: Colors.black.withOpacity(0.2),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
        ],
      );
}
