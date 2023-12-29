import 'package:app/extensions/context.dart';
import 'package:app/features/auth/screens/email_auth/view_model.dart';
import 'package:app/features/auth/screens/myapp/view_model.dart';
import 'package:app/primary/buttons/button.dart';
import 'package:app/primary/other/primary_circular_wrapper.dart';
import 'package:app/primary/text_fields/email_auth.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailAuthScreen extends ConsumerWidget {
  const EmailAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(emailAuthViewModelProvider);

    return PrimaryCircularWrapper(
      isLoading: data.isLoading,
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        bottomNavigationBar: PrimaryButton(
          text: 'ログイン',
          isBottomNavigationBar: true,
          circularRadius: 50,
          onPressed: () async =>
              _handleSignInWithEmailAndPassword(ref, context),
        ),
        body: ListView(
          padding: const EdgeInsets.all(kDefaultPadding),
          children: [
            const Wrap(
              spacing: 12,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/icons/email.png'),
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/icons/pass.png'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'メールアドレスでログイン',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '現在は限られたユーザーでのみでしかメールアドレス認証はできません。ご不便をおかけして申し訳ございません。',
              style: StyleName.description,
            ),
            const SizedBox(height: 32),
            PrimaryEmailAuthTextField(
              controller: data.emailController,
              hintText: 'taro@gmail.com',
              labelText: 'メールアドレス',
              prefixIcon: const Icon(
                FontAwesomeIcons.envelope,
                size: 20,
              ),
            ),
            const SizedBox(height: 24),
            PrimaryEmailAuthTextField(
              controller: data.passController,
              obscureText: data.obscureText,
              hintText: '英数字8文字以上',
              labelText: 'パスワード',
              prefixIcon: const Icon(FontAwesomeIcons.lock, size: 20),
              suffixIcon: IconButton(
                onPressed: () => _handleUpdateObscureText(ref),
                icon: Icon(
                  data.obscureText ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleUpdateObscureText(WidgetRef ref) =>
      ref.read(emailAuthViewModelProvider.notifier).updateObscureText();

  Future<void> _handleSignInWithEmailAndPassword(
    WidgetRef ref,
    BuildContext context,
  ) async =>
      ref
          .read(emailAuthViewModelProvider.notifier)
          .signInWithEmailAndPassword()
          .then((value) {
        Navigator.pop(context); // page
        Navigator.pop(context); // AuthBottomSheet
        ref.invalidate(myAppViewModelProvider);
      }).catchError((e) {
        context.errorDialog(e);
      });
}
