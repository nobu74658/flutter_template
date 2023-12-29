import 'package:app/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpBottomDescription extends StatelessWidget {
  const SignUpBottomDescription({super.key});

  @override
  Widget build(BuildContext context) => Align(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: StyleName.description,
            children: [
              const TextSpan(
                text: 'サインインをする事で当サービスの\n',
              ),
              TextSpan(
                text: '利用規約',
                style: const TextStyle(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => debugPrint('利用規約　たっぷ'),
              ),
              const TextSpan(
                text: '・',
              ),
              TextSpan(
                text: 'プライバシーポリシー',
                style: const TextStyle(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => debugPrint('プライバシーポリシー　たっぷ'),
              ),
              const TextSpan(
                text: 'に同意した事を意味します。',
              ),
            ],
          ),
        ),
      );
}
