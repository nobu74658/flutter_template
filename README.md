## 概要
Dart-define-from-fileを使って開発環境と本番環境を分ける記事（ https://zenn.dev/altiveinc/articles/separating-environments-in-flutter ）を元に
setup.shを実行すると9割程自動で環境を分けることができるテンプレートです。
そのほかに自分の好みでlibファイルにログイン機能などが入っているので、分離して別のプロジェクトに公開しようと思います。


## set up
### requirements
- mac os
- flutter doctor
``` bash
[✓] Flutter (Channel stable, 3.16.3, on macOS 14.0 23A344 darwin-arm64, locale ja-JP)
[✓] Android toolchain - develop for Android devices (Android SDK version 32.1.0-rc1)
[✓] Xcode - develop for iOS and macOS (Xcode 15.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2021.3)
[✓] VS Code (version 1.85.1)
[✓] Connected device (5 available)
[✓] Network resources
```

### install
1. setup.shを実行
``` bash
bash setup.sh [project-name]
```
bundleIDは [project-name].app になります
例 bash setup.sh com.hoge → com.hoge.app

2. Edit dart_defines/
3. Set Product Bundle Identifier to $(appId) in iOS Build Settings
4. Add a new run script as follows in iOS Build Phases:
    cp -f \${SRCROOT}/\${flavor}/GoogleService-Info.plist \${SRCROOT}/Runner/GoogleService-Info.plist
5. Product > Scheme > Edit Scheme
   Select Pre-actions and Add New Run Script Action
    \${SRCROOT}/scripts/extract_dart_defines.sh

## build mode
### 種類
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

※ cli上からビルドするときは.vscode/launch.jsonファイル内を参考に
```
flutter run --[buildMode] --[args]
```
