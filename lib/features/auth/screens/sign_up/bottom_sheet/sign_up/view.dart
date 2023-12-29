import 'package:app/extensions/context.dart';
import 'package:app/features/auth/screens/sign_up/bottom_sheet/sign_up/components/bottom_description.dart';
import 'package:app/features/auth/screens/sign_up/bottom_sheet/sign_up/components/head.dart';
import 'package:app/features/auth/screens/sign_up/bottom_sheet/sign_up/components/sign_up_type_bottom.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

class SignUpBottomSheet extends StatelessWidget {
  const SignUpBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kDefaultPadding).copyWith(
          top: kDefaultPadding * 2,
          bottom: context.bottomSafeArea + kDefaultPadding * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SignUpBottomSheetHead(),

            /// Google・Apple・Email
            for (final type in SignUpType.values) SignUpTypeButton(type),
            const SizedBox(height: 32),

            /// 利用規約・プライバシーポリシー
            const SignUpBottomDescription(),
          ],
        ),
      );
}
