import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/shared_preferences_helper.dart';

void main() {
  group("SharedPreferencesHelper", () {
    Map<String, dynamic> preferences = {};

    // Because shared_preferences uses a singleton we can't arrange for it to return different values in different tests
    // Once this is closed https://github.com/flutter/flutter/issues/25407 better testing will arrive
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return preferences;
      }
      if (methodCall.method == 'setDouble') {
        preferences[methodCall.arguments["key"]] =
            methodCall.arguments["value"];
      }
      return null;
    });

    test("Show Unknown", () async {
      final settingsHelper = SharedPreferencesHelper();
      final defaultValue = false;
      final setValue = true;

      final defaultShowUnknown = await settingsHelper.getShowUnknown();

      expect(defaultShowUnknown, equals(defaultValue),
          reason: "when no preference exists we should return default");

      settingsHelper.setShowUnknown(setValue);

      final setShowUnknown = await settingsHelper.getShowUnknown();

      expect(setShowUnknown, equals(setValue),
          reason: "when preference has been set we should return it");
    });

    test("Warning Level", () async {
      final settingsHelper = SharedPreferencesHelper();
      final defaultValue = 10.0;
      final setValue = 9.5;

      final defaultWarningLevel = await settingsHelper.getWarningLevel();

      expect(defaultWarningLevel, equals(defaultValue),
          reason: "when no preference exists we should return default");

      settingsHelper.setWarningLevel(setValue);

      final setWarningLevel = await settingsHelper.getWarningLevel();

      expect(setWarningLevel, equals(setValue),
          reason: "when preference has been set we should return it");
    });
  });
}
