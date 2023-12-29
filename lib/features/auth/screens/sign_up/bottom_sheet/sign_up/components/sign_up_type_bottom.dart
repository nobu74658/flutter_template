import 'dart:io';

import 'package:app/extensions/context.dart';
import 'package:app/features/auth/screens/email_auth/view.dart';
import 'package:app/features/auth/screens/myapp/view_model.dart';
import 'package:app/features/auth/screens/sign_up/bottom_sheet/sign_up/view_model.dart';
import 'package:app/primary/other/show_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SignUpType {
  google(FontAwesomeIcons.google, 'Googleで続ける'),
  apple(FontAwesomeIcons.apple, 'Appleで続ける'),
  email(FontAwesomeIcons.envelope, 'メールアドレスで続ける'),
  ;

  const SignUpType(
    this.iconData,
    this.displayName,
  );

  final IconData iconData;
  final String displayName;
}

class SignUpTypeButton extends ConsumerWidget {
  const SignUpTypeButton(this.type, {super.key});

  final SignUpType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Android ユーザーのみ Apple 認証を表示しない
    if (!kIsWeb && Platform.isAndroid && type == SignUpType.apple) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: type == SignUpType.email ? 0 : 12),
      child: InkWell(
        onTap: () async => _handleClicked(ref, context),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              Icon(type.iconData),
              Expanded(
                child: Text(
                  type.displayName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleClicked(WidgetRef ref, BuildContext context) async {
    /// メールの場合は画面遷移
    if (type == SignUpType.email) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const EmailAuthScreen(),
        ),
      );
      return;
    }

    /// Apple・Googleでのサインインの場合は認証処理
    SD.circular(context);
    await ref
        .read(signUpBottomSheetViewModelProvider.notifier)
        .signUp(type)
        .then((value) {
      Navigator.pop(context); // サーキュラー
      Navigator.pop(context); // AuthBottomSheet
      ref.invalidate(myAppViewModelProvider);
    }).catchError((e) {
      Navigator.pop(context);
      context.errorDialog(e);
    });
  }
}
