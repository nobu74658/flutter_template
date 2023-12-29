## set up
### requirements
- mac os
- gradle
  - https://docs.gradle.org/current/userguide/installation.html

- flutter doctor
[✓] Flutter (Channel stable, 3.16.3, on macOS 14.0 23A344 darwin-arm64, locale ja-JP)
[✓] Android toolchain - develop for Android devices (Android SDK version 32.1.0-rc1)
[✓] Xcode - develop for iOS and macOS (Xcode 15.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2021.3)
[✓] VS Code (version 1.85.1)
[✓] Connected device (5 available)
[✓] Network resources

### install
- setup.txtを実行
``` bash
bash setup.txt
```

- 1. Edit appName in dart_defines/
- 2. Add \$(appIdSuffix) in iOS Build Settings
- 3. Add a new run script as follows in iOS Build Phases:
    cp -f ${SRCROOT}/${flavor}/GoogleService-Info.plist ${SRCROOT}/GoogleService-Info.plist

## build mode
### 概要
- Debug dev
  - 開発用Firebase
  - debug機能
- Debug stg
  - 本番用Firebase
  - debug機能
- Release prod
  - 本番用Firebase
  - releaseモード（インストールされたアプリで確認）

※ stg, prodは実機のみ

### ビルド方法
- build modeを選択して、ビルド
- 例）Debug devを選択していることを確認して、F5やGUIからビルドする
<img width="272" alt="スクリーンショット 2023-11-17 11 55 04" src="https://github.com/junki-pw/ale_mobile_app/assets/82300323/ded7ae81-e538-498c-ba25-6aba9d592b76">


※ android studio は各自で設定　https://zenn.dev/mamushi/scraps/13c0232c88227e  
※ cli上からビルドするときは.vscode/launch.jsonファイル内のビルドモードいずれかを見て、「flutter run --$(flutterMode) $(args[0])
