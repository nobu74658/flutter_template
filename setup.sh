#!/bin/bash

# flutter プロジェクト作成
# 例： bash setup.sh com.hoge なら com.hoge.app というパッケージ名になる
read -p "Enter Project Name (例: app): " projectName
read -p "Enter Organization（例: com.example）: " org
flutter create . --project-name=$projectName --org $org --platforms ios,android,web
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# 本番環境と開発環境のfirebaseを選択
read -p "Enter iOS Bundle ID: " iosBundleId
read -p "Enter Android Package Name: " androidPackageName

## 本番環境
printf "\e[1;34msetup release firebase project\e[0m\n"
flutterfire configure --ios-bundle-id="$iosBundleId" --android-package-name="$androidPackageName"
mkdir lib/const/firebase
mv lib/firebase_options.dart lib/const/firebase/firebase_prod_options.dart
### ios
mkdir ios/prod
cp ios/Runner/GoogleService-Info.plist ios/prod/GoogleService-Info.plist
cp ios/firebase_app_id_file.json ios/prod/firebase_app_id_file.json
mkdir ios/stg
mv ios/Runner/GoogleService-Info.plist ios/stg/GoogleService-Info.plist
mv ios/firebase_app_id_file.json ios/stg/firebase_app_id_file.json
### android
mkdir android/app/src/prod
cp android/app/google-services.json android/app/src/prod/google-services.json
mkdir android/app/src/stg
mv android/app/google-services.json android/app/src/stg/google-services.json

## 開発環境
printf "\e[1;34msetup development firebase project\e[0m\n"
flutterfire configure --ios-bundle-id="$iosBundleId.dev" --android-package-name="$androidPackageName.dev"
mv lib/firebase_options.dart lib/const/firebase/firebase_dev_options.dart
### ios
mkdir ios/dev
cp ios/Runner/GoogleService-Info.plist ios/dev/GoogleService-Info.plist
mv ios/firebase_app_id_file.json ios/dev/firebase_app_id_file.json
### android
mkdir android/app/src/dev
cp android/app/google-services.json android/app/src/dev/google-services.json

# 本番環境と開発環境を分けるための設定
## android/app/build.gradle
# dart-define を入れる変数を宣言
buildGradleFile="android/app/build.gradle"
newCode='// dart-define を入れる変数を宣言\
def dartDefines = [:];\
if (project.hasProperty(\047dart-defines\047)) {\
    // カンマ区切りかつBase64でエンコードされている dart-defines をデコードして変数に格納します。\
    dartDefines = dartDefines + project.property(\047dart-defines\047)\
        .split(\047,\047)\
        .collectEntries { entry ->\
            def pair = new String(entry.decodeBase64(), \047UTF-8\047).split(\047=\047)\
            [(pair.first()): pair.last()]\
        }\
}\
'
lineNumber=$(awk '/def flutterVersionName = localProperties.getProperty/{print NR}' "$buildGradleFile")
awk -v line="$lineNumber" -v text="$newCode" 'NR == line {printf "%s\n", text} {print}' "$buildGradleFile" > temp.gradle && mv temp.gradle "$buildGradleFile"

# 変数を設定
cd android/app
awk '/defaultConfig \{/{p=1} p && !/defaultConfig \{/{c=4; printf "        minSdkVersion 24\n        applicationId \"${dartDefines.appId}\"\n        resValue \"string\", \"app_name\", \"${dartDefines.appName}\"\n"; p=0; next} c {c--; next} 1' build.gradle > build.gradle.tmp && mv build.gradle.tmp build.gradle

# Firebase対応
echo '
task selectGoogleServicesJson(type: Copy) {
    from "src/${dartDefines.flavor}/google-services.json"
    into "./"
}

tasks.whenTaskAdded { task ->
    if (task.name == "processDebugGoogleServices" || task.name == "processReleaseGoogleServices") {
        task.dependsOn selectGoogleServicesJson
    }
}' >> build.gradle

## android/app/src/main/AndroidManifest.xml
cd src/main
awk '/android:label=/ {gsub(/android:label="[^"]*"/, "android:label=\"@string\/app_name\"")} 1' AndroidManifest.xml > tmpfile && mv tmpfile AndroidManifest.xml
cd ../../../../

## ios scriptファイル
mkdir ios/scripts
mv extract_dart_defines.sh ios/scripts/extract_dart_defines.sh
chmod 755 ios/scripts/extract_dart_defines.sh

## ios/Runner/Info.plist に写真フォルダへのアクセス許可を追加
/usr/libexec/PlistBuddy -c "Add :NSPhotoLibraryUsageDescription string 'アプリ機能のプロフィールなどに表示・使用するための写真や動画を表示する目的でリクエストします。'" ios/Runner/Info.plist

## keyとstringを設定
awk '/<key>CFBundleName<\/key>/ {getline; printf "   <key>CFBundleName<\/key>\n   <string>\$(appName)<\/string>\n"; next} 1' ios/Runner/Info.plist | sed 's/^/ /' > Info_tmp.plist && mv Info_tmp.plist ios/Runner/Info.plist
awk '/<key>CFBundleDisplayName<\/key>/ {getline; printf "   <key>CFBundleDisplayName</key>\n   <string>$(appName)</string>\n"; next} 1' ios/Runner/Info.plist | sed 's/^/ /' > Info_tmp.plist && mv Info_tmp.plist ios/Runner/Info.plist

## includeを追加
echo "#include \"Dart-Defines.xcconfig\"" >> ios/Flutter/Debug.xcconfig
echo "#include \"Dart-Defines.xcconfig\"" >> ios/Flutter/Release.xcconfig

## REVERSED_CLIENT_IDを追加
awk '/<\/dict>/ {
  print "    <key>CFBundleURLTypes</key>"
  print "    <array>"
  print "        <dict>"
  print "            <key>CFBundleTypeRole</key>"
  print "            <string>Editor</string>"
  print "            <key>CFBundleURLSchemes</key>"
  print "            <array>"
  print "                <string>\$\(googleReversedClientId\)</string>"
  print "            </array>"
  print "        </dict>"
  print "    </array>"
} 1' ios/Runner/Info.plist > Info.plist.tmp && mv Info.plist.tmp ios/Runner/Info.plist


## ios/Podfile Firebaseの設定
awk '/target '\''Runner'\'' do/,/end/ {
  if ($0 ~ /flutter_install_all_ios_pods/) {
    print "  pod \047FirebaseFirestore\047, :git => \047https://github.com/invertase/firestore-ios-sdk-frameworks.git\047, :tag => \04710.9.0\047"
  }
} !/target '\''Runner'\'' do/,/end/' ios/Podfile > ios/Podfile.tmp && mv ios/Podfile.tmp ios/Podfile

awk '/flutter_additional_ios_build_settings\(target\)/,/end/ {
    if ($0 ~ /end/) {
        print "    target.build_configurations.each do |config|"
        print "      config.build_settings[\047IPHONEOS_DEPLOYMENT_TARGET\047] = \04713.0\047"
        print ""
        print "      xcconfig_path = config.base_configuration_reference.real_path"
        print "      xcconfig = File.read(xcconfig_path)"
        print "      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, \047TOOLCHAIN_DIR\047)"
        print "      File.open(xcconfig_path, \047w\047) { |file| file << xcconfig_mod }"
        print "    end"
    }
} !/target '\''Runner'\'' do/,/end/' ios/Podfile > ios/Podfile.tmp && mv ios/Podfile.tmp ios/Podfile


# 手動で設定する必要がある箇所を表示
printf "\e[1;34m----------------------------------------------------------\n"
printf '1. Edit dart_defines/\n'
printf '2. Set Product Bundle Identifier to $(appId) in iOS Build Settings\n'
printf "3. Add a new run script as follows in iOS Build Phases:\n"
printf "    cp -f \${SRCROOT}/\${flavor}/GoogleService-Info.plist \${SRCROOT}/Runner/GoogleService-Info.plist\n"
printf "4. Product > Scheme > Edit Scheme \n"
printf "   Select Pre-actions and Add New Run Script Action\n"
printf "    \${SRCROOT}/scripts/extract_dart_defines.sh\n"
printf "\e[1;34m----------------------------------------------------------\e[0m\n"
rm setup.sh
