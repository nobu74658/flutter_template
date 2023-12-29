import 'dart:async';

import 'package:app/features/auth/screens/myapp/view.dart';
import 'package:app/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 初期化処理
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
