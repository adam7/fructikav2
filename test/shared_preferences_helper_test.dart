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
      final expectedDefault = false;
      final setValue = true;

      expect((await settingsHelper.getShowUnknown()), equals(expectedDefault),
          reason: "when no preference exists we should return default");

      settingsHelper.setShowUnknown(setValue);

      expect((await settingsHelper.getShowUnknown()), equals(setValue),
          reason: "when preference has been set we should return it");
    });

    test("Warning Level", () async {
      final settingsHelper = SharedPreferencesHelper();

      final expectedDefault = 10.0;
      final setValue = 9.5;


      expect((await settingsHelper.getWarningLevel()), equals(expectedDefault),
          reason: "when no preference exists we should return default");

      settingsHelper.setWarningLevel(setValue);

      expect((await settingsHelper.getWarningLevel()), equals(setValue),
          reason: "when preference has been set we should return it");
    });

    test("Dark Mode", () async {
      final settingsHelper = SharedPreferencesHelper();

      final expectedDefault = false;
      final setValue = true;

      expect((await settingsHelper.getDarkMode()), equals(expectedDefault),
          reason: "when no preference exists we should return default");

      settingsHelper.setDarkMode(setValue);

      expect((await settingsHelper.getDarkMode()), equals(setValue),
          reason: "when preference has been set we should return it");
    });
  });
}
