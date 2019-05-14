import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesHelper{  
  Future<bool> getShowUnknown();
  Future<void> setShowUnknown(bool value);
  Future<double> getWarningLevel();
  Future<void> setWarningLevel(double value);
}

class SharedPreferencesHelper extends PreferencesHelper {
  final unknownKey = "_unknown";
  final warningKey = "_warning";

  Future<bool> getShowUnknown() async {
    final defaultResult = false;
    var prefs = await SharedPreferences.getInstance();

    try {
      return prefs.getBool(unknownKey) ?? defaultResult;
    } catch (exception) {
      return defaultResult;
    }
  }

  Future<void> setShowUnknown(bool value) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.setBool(unknownKey, value);
  }

  Future<double> getWarningLevel() async {
    final defaultResult = 10.0;
    var prefs = await SharedPreferences.getInstance();

    try {
      return prefs.getDouble(warningKey) ?? defaultResult;
    } catch (exception) {
      return defaultResult;
    }
  }

  Future<void> setWarningLevel(double value) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.setDouble(warningKey, value);
  }
}
