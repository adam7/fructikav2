import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/utilities/theme_data.dart';

void main() {
  test("When calling buildFructikaTheme", () async {
    final themeData = buildFructikaTheme();

    expect(themeData.primaryColor, equals(fructikaPrimary));
    expect(themeData.primaryColorDark, equals(fructikaPrimaryDark));
    expect(themeData.primaryColorLight, equals(fructikaPrimaryLight));
    expect(themeData.accentColor, equals(fructikaSecondary));
    expect(themeData.errorColor, equals(fructikaErrorRed));
  });
}
