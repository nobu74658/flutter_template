import 'dart:async';

import 'package:app/const/firebase/firebase_dev_options.dart' as dev;
import 'package:app/const/firebase/firebase_prod_options.dart' as prod;
import 'package:app/features/auth/screens/myapp/view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: do_not_use_environment
  const isDev = String.fromEnvironment('flavor') == 'dev';

  /// 初期化処理
  await Firebase.initializeApp(
    options: isDev
        ? dev.DefaultFirebaseOptions.currentPlatform
        : prod.DefaultFirebaseOptions.currentPlatform,
  );

  unawaited(
    /// 縦画面専用
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (_) => runApp(
        ProviderScope(
          child: DevicePreview(
            enabled: kIsWeb && kDebugMode,
            builder: (context) => const MyApp(),
          ),
        ),
      ),
    ),
  );
}
