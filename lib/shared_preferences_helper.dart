import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesHelper {
  Future<bool> getShowUnknown();
  Future<void> setShowUnknown(bool value);
  Future<double> getWarningLevel();
  Future<void> setWarningLevel(double value);
  final defaultShowUnknown = false;
  final defaultWarningLevel = 10.0;
}

class SharedPreferencesHelper extends PreferencesHelper {
  final _unknownKey = "_unknown";
  final _warningKey = "_warning";

  Future<bool> getShowUnknown() async {
    var prefs = await SharedPreferences.getInstance();

    try {
      return prefs.getBool(_unknownKey) ?? defaultShowUnknown;
    } catch (exception) {
      return defaultShowUnknown;
    }
  }

  Future<void> setShowUnknown(bool value) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_unknownKey, value);
  }

  Future<double> getWarningLevel() async {
    var prefs = await SharedPreferences.getInstance();

    try {
      return prefs.getDouble(_warningKey) ?? defaultWarningLevel;
    } catch (exception) {
      return defaultWarningLevel;
    }
  }

  Future<void> setWarningLevel(double value) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.setDouble(_warningKey, value);
  }
}
