import 'package:app/extensions/context.dart';
import 'package:app/features/auth/screens/entrance/view.dart';
import 'package:app/features/auth/screens/myapp/view_model.dart';
import 'package:app/features/auth/screens/sign_up/view.dart';
import 'package:app/primary/other/when_error_widget.dart';
import 'package:app/providers/firebase_provider.dart';
import 'package:app/utils/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(myAppViewModelProvider).when(
            loading: _Loading.new,
            error: (error, stack) =>
                MaterialApp(home: PrimaryWhenErrorWidget(error)),
            data: (data) {
              /// 認証済みかどうか
              final bool isLogin =
                  ref.read(firebaseAuthProvider).currentUser != null;

              /// 認証前
              if (!isLogin) {
                return MaterialApp(
                  theme: ThemeData(useMaterial3: false),
                  locale: DevicePreview.locale(context),
                  builder: DevicePreview.appBuilder,
                  home: const SignUpScreen(),
                );
              }

              return MaterialApp(
                theme: getAppTheme(),
                locale: DevicePreview.locale(context),
                builder: DevicePreview.appBuilder,
                home: const EntranceScreen(),
              );
            },
          );
}

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: SizedBox(
                height: context.deviceWidth * 0.7,
                width: context.deviceWidth * 0.7,
                child: Lottie.asset('assets/lottie/initial_loading.json'),
              ),
            ),
          ),
        ),
      );
}
