# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - 2026-01-11

### Flutter Upgrade to 3.38.6 (Dart 3.10.7)

This release upgrades the project from an older Flutter version to Flutter 3.38.6 (stable) with Dart 3.10.7, fixing all breaking changes and deprecated APIs.

#### Summary of Changes

- ✅ Updated Dart SDK constraints to support Dart 3.x
- ✅ Fixed null safety issues across all form widgets
- ✅ Replaced deprecated `RaisedButton` with `ElevatedButton`
- ✅ Modernized Android build configuration
- ✅ Removed Android v1 embedding
- ✅ Updated Gradle, AGP, and Kotlin to latest versions
- ✅ Fixed Android 12+ compatibility issues
- ✅ Updated widget tests to match actual app functionality

---

## How to Perform This Upgrade (Detailed Steps)

If you need to perform a similar upgrade on another Flutter project, follow these steps:

### Step 1: Update Flutter SDK

```bash
# Switch to stable channel (if not already)
flutter channel stable

# Update Flutter to the latest version
flutter upgrade

# Verify Flutter version
flutter --version
```

### Step 2: Update pubspec.yaml

Update your `pubspec.yaml` file with modern SDK constraints and dependencies:

```yaml
environment:
  sdk: ">=3.0.0 <4.0.0"  # Changed from ">=2.1.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8  # Changed from ^0.1.2
```

Run:
```bash
flutter pub upgrade
flutter pub outdated  # Check for any outdated packages
```

### Step 3: Fix Null Safety Issues in Dart Code

**Problem:** Dart 3.x enforces stricter null safety. Form validators and callbacks need nullable types.

**Before:**
```dart
validator: (String value) {
  if (value.isEmpty) {
    return 'Please enter your phone number';
  }
  return null;
},
onSaved: (String value) => phoneNumber = value,
```

**After:**
```dart
validator: (String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  return null;
},
onSaved: (String? value) => phoneNumber = value ?? '',
```

**Also update form state access to be null-safe:**

**Before:**
```dart
if (_formKey.currentState.validate()) {
  _formKey.currentState.save();
}
```

**After:**
```dart
if (_formKey.currentState?.validate() ?? false) {
  _formKey.currentState?.save();
}
```

**And update dropdown onChanged callbacks:**

**Before:**
```dart
onChanged: (String newValue) {
  changeValue(newValue);
}
```

**After:**
```dart
onChanged: (String? newValue) {
  changeValue(newValue!);
}
```

### Step 4: Replace Deprecated Button Widgets

**Problem:** `RaisedButton` and `ButtonTheme` are deprecated.

**Before:**
```dart
Center(
  child: ButtonTheme(
    minWidth: 800.0,
    height: 40.0,
    child: RaisedButton(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      onPressed: () { /* ... */ },
      child: Text('Login'),
    ),
  ),
)
```

**After:**
```dart
Center(
  child: SizedBox(
    width: 800.0,
    height: 40.0,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      onPressed: () { /* ... */ },
      child: Text('Login'),
    ),
  ),
)
```

### Step 5: Update Android Configuration

#### 5.1 Remove Android v1 Embedding

Edit `android/app/src/main/AndroidManifest.xml`:

**Before:**
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.flutter_aos">
    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="flutter_aos"
        android:icon="@mipmap/ic_launcher">
```

**After:**
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="flutter_aos"
        android:icon="@mipmap/ic_launcher">
```

#### 5.2 Add android:exported for Android 12+

In `android/app/src/main/AndroidManifest.xml`, add `android:exported="true"` to the MainActivity:

```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    ...>
```

#### 5.3 Update Gradle Wrapper

Edit `android/gradle/wrapper/gradle-wrapper.properties`:

**Before:**
```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-5.6.2-all.zip
```

**After:**
```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.7-all.zip
```

#### 5.4 Update Root build.gradle

Edit `android/build.gradle`:

**Before:**
```groovy
buildscript {
    ext.kotlin_version = '1.3.50'
    repositories {
        google()
        jcenter()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.5.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        google()
        jcenter()
    }
}
```

**After:**
```groovy
buildscript {
    ext.kotlin_version = '2.1.0'
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.6.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

**Note:** Replace `jcenter()` with `mavenCentral()` as JCenter is deprecated.

#### 5.5 Update settings.gradle to Declarative Plugin Format

Edit `android/settings.gradle`:

**Before:**
```groovy
include ':app'

def localPropertiesFile = new File(rootProject.projectDir, "local.properties")
def properties = new Properties()

assert localPropertiesFile.exists()
localPropertiesFile.withReader("UTF-8") { reader -> properties.load(reader) }

def flutterSdkPath = properties.getProperty("flutter.sdk")
assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
apply from: "$flutterSdkPath/packages/flutter_tools/gradle/app_plugin_loader.gradle"
```

**After:**
```groovy
pluginManagement {
    def flutterSdkPath = {
        def properties = new Properties()
        file("local.properties").withInputStream { properties.load(it) }
        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
        return flutterSdkPath
    }()

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.6.0" apply false
    id "org.jetbrains.kotlin.android" version "2.1.0" apply false
}

include ":app"
```

#### 5.6 Update App-Level build.gradle

Edit `android/app/build.gradle`:

**Before:**
```groovy
def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    compileSdkVersion 29

    defaultConfig {
        applicationId "com.example.flutter_aos"
        minSdkVersion flutter.minSdkVersion
        targetSdkVersion 29
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
}
```

**After:**
```groovy
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace 'com.example.flutter_aos'
    compileSdk 34

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    defaultConfig {
        applicationId "com.example.flutter_aos"
        minSdkVersion flutter.minSdkVersion
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
}
```

**Key changes:**
- Use declarative `plugins {}` block
- Add `namespace` and remove `package` from AndroidManifest
- Update to `compileSdk 34`
- Add `compileOptions` and `kotlinOptions` for JVM target compatibility
- Use `flutter.targetSdkVersion` instead of hardcoded version

### Step 6: Clean and Rebuild

```bash
# Clean the project
flutter clean

# Get dependencies
flutter pub get

# Run static analysis
flutter analyze

# Build the app
flutter build apk --debug

# Run tests
flutter test
```

### Step 7: Fix Test Files

Update your test files to match your actual app. For example, if your test was for a counter app but you have a login app:

**Before:**
```dart
testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  await tester.pumpWidget(App());
  expect(find.text('0'), findsOneWidget);
  // ...
});
```

**After:**
```dart
testWidgets('App loads register page', (WidgetTester tester) async {
  await tester.pumpWidget(App());
  expect(find.text('Register'), findsOneWidget);
});
```

---

## Detailed Changes in This Project

### Modified Files

#### Dart/Flutter Code
- **[pubspec.yaml](pubspec.yaml)**
  - Updated SDK constraint: `sdk: ">=3.0.0 <4.0.0"`
  - Updated `cupertino_icons: ^1.0.8`

- **[lib/pages/login/form.dart](lib/pages/login/form.dart)**
  - Updated validators to accept `String?` instead of `String`
  - Updated `onSaved` callbacks to handle nullable strings
  - Replaced `RaisedButton` with `ElevatedButton`
  - Replaced `ButtonTheme` with `SizedBox`
  - Updated form state access with null-safe operators
  - Updated dropdown `onChanged` to accept `String?`

- **[lib/pages/register/form.dart](lib/pages/register/form.dart)**
  - Same changes as login form
  - Updated `validateAndSave()` method with null-safe form access

- **[test/widget_test.dart](test/widget_test.dart)**
  - Updated test to match actual app (register page)
  - Removed unused imports

#### Android Configuration
- **[android/gradle/wrapper/gradle-wrapper.properties](android/gradle/wrapper/gradle-wrapper.properties)**
  - Updated Gradle: `5.6.2` → `8.7`

- **[android/build.gradle](android/build.gradle)**
  - Updated Kotlin: `1.3.50` → `2.1.0`
  - Updated AGP: `3.5.0` → `8.6.0`
  - Replaced `jcenter()` with `mavenCentral()`

- **[android/settings.gradle](android/settings.gradle)**
  - Migrated to declarative plugin management
  - Added plugin versions: AGP 8.6.0, Kotlin 2.1.0

- **[android/app/build.gradle](android/app/build.gradle)**
  - Migrated to declarative `plugins {}` block
  - Added `namespace` declaration
  - Updated `compileSdk` to 34
  - Added JVM target compatibility settings
  - Updated to use `flutter.targetSdkVersion`

- **[android/app/src/main/AndroidManifest.xml](android/app/src/main/AndroidManifest.xml)**
  - Removed `package` attribute (uses namespace now)
  - Removed `android:name="io.flutter.app.FlutterApplication"`
  - Added `android:exported="true"` for Android 12+ compatibility

### Verification Results

All checks passed successfully:

```bash
$ flutter analyze
Analyzing flutter_aos...
No issues found! (ran in 10.0s)

$ flutter test
00:01 +1: All tests passed!

$ flutter build apk --debug
✓ Built build/app/outputs/flutter-apk/app-debug.apk
```

### Breaking Changes Fixed

1. **Null Safety**: All form validators and callbacks updated for Dart 3.x null safety
2. **Deprecated Widgets**: `RaisedButton` → `ElevatedButton`, `ButtonTheme` removed
3. **Android v1 Embedding**: Removed deprecated v1 embedding code
4. **Android 12+**: Added required `android:exported` attribute
5. **Gradle Plugin**: Migrated from imperative to declarative plugin application
6. **JVM Target**: Added explicit JVM target compatibility to avoid compilation errors

### Dependencies Updated

| Package | Old Version | New Version |
|---------|-------------|-------------|
| Dart SDK | >=2.1.0 <3.0.0 | >=3.0.0 <4.0.0 |
| cupertino_icons | ^0.1.2 | ^1.0.8 |
| Gradle | 5.6.2 | 8.7 |
| Android Gradle Plugin | 3.5.0 | 8.6.0 |
| Kotlin | 1.3.50 | 2.1.0 |

### Known Issues

None. All tests pass and the app builds successfully.

---

## Common Issues and Solutions

### Issue 1: "Could not initialize class org.codehaus.groovy.reflection.ReflectionCache"

**Cause:** Gradle version too old for current Java/Kotlin versions.

**Solution:** Update Gradle to at least 8.7 in `gradle-wrapper.properties`.

### Issue 2: "android:exported needs to be explicitly specified"

**Cause:** Android 12+ requires explicit `android:exported` attribute.

**Solution:** Add `android:exported="true"` to MainActivity in AndroidManifest.xml.

### Issue 3: "Inconsistent JVM-target compatibility detected"

**Cause:** Mismatch between Java and Kotlin JVM targets.

**Solution:** Add to `android/app/build.gradle`:
```groovy
compileOptions {
    sourceCompatibility JavaVersion.VERSION_1_8
    targetCompatibility JavaVersion.VERSION_1_8
}

kotlinOptions {
    jvmTarget = '1.8'
}
```

### Issue 4: "You are applying Flutter's app_plugin_loader Gradle plugin imperatively"

**Cause:** Old-style Gradle plugin application is deprecated.

**Solution:** Migrate `settings.gradle` to use declarative `pluginManagement` and `plugins {}` blocks as shown in Step 5.5 above.

### Issue 5: "The argument type 'String? Function(String)' can't be assigned"

**Cause:** Dart 3.x requires nullable type annotations.

**Solution:** Update all validators and callbacks to accept nullable types:
- `validator: (String value)` → `validator: (String? value)`
- `onSaved: (String value)` → `onSaved: (String? value)`

---

## References

- [Flutter 3.x Migration Guide](https://docs.flutter.dev/release/breaking-changes)
- [Dart 3 Null Safety](https://dart.dev/null-safety)
- [Android Gradle Plugin 8.x Migration](https://developer.android.com/build/releases/gradle-plugin)
- [Flutter Android Embedding v2](https://docs.flutter.dev/development/platform-integration/android/android-embedding)

---

*For questions or issues with this upgrade, please check the Flutter documentation or file an issue in the project repository.*
