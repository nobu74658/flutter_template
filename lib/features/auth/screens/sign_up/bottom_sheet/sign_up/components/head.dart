import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

class SignUpBottomSheetHead extends StatelessWidget {
  const SignUpBottomSheetHead({super.key});

  @override
  Widget build(BuildContext context) => const Align(
        child: Column(
          children: [
            Text(
              'ようこそ！',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'サインインの方法を選択して下さい',
              style: StyleName.description,
            ),
            SizedBox(height: 24),
          ],
        ),
      );
}
