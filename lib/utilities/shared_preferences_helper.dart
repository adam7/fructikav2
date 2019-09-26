import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesHelper {
  Future<bool> getShowUnknown();
  Future<void> setShowUnknown(bool value);
  Future<bool> getDarkMode();
  Future<void> setDarkMode(bool value);
  Future<double> getWarningLevel();
  Future<void> setWarningLevel(double value);
}

class SharedPreferencesHelper extends PreferencesHelper {
  final _unknownKey = "_unknown";
  final _warningKey = "_warning";
  final _darkModeKey = "_darkMode";

  Future<bool> _getBoolOrDefault(String key, bool defaultValue) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      return prefs.getBool(key) ?? defaultValue;
    } catch (exception) {
      return defaultValue;
    }
  }

  Future<void> _setBool(String key, bool value) async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(key, value);
  }

  Future<bool> getShowUnknown() async {
    return _getBoolOrDefault(_unknownKey, false);
  }

  Future<void> setShowUnknown(bool value) async {
    _setBool(_unknownKey, value);
  }

  Future<bool> getDarkMode() async {
    return _getBoolOrDefault(_darkModeKey, false);
  }

  Future<void> setDarkMode(bool value) async {
    _setBool(_darkModeKey, value);
  }

  Future<double> getWarningLevel() async {
    final defaultValue = 10.0;
    final prefs = await SharedPreferences.getInstance();    

    try {
      return prefs.getDouble(_warningKey) ?? defaultValue;
    } catch (exception) {
      return defaultValue;
    }
  }

  Future<void> setWarningLevel(double value) async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(_warningKey, value);
  }
}
