import 'package:app/extensions/context.dart';
import 'package:app/features/auth/screens/sign_up/bottom_sheet/sign_up/view.dart';
import 'package:app/features/auth/screens/sign_up/view_model.dart';
import 'package:app/primary/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      signUpViewModelProvider,
      (previous, next) => SD.bottomSheet(
        context: context,
        child: const SignUpBottomSheet(),
        isDismissible: false,
        barrierColor: Colors.transparent,
        enableDrag: false,
      ),
    );

    return Scaffold(
      body: Align(
        child: Column(
          children: [
            SizedBox(height: context.deviceHeight * 0.1),
            const Text(
              'app name',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'description',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
