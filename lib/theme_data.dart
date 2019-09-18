import 'package:flutter/material.dart';

final fructikaPrimary = Colors.greenAccent.shade200;
final fructikaPrimaryLight = Color(0xff9fffe0);
final fructikaPrimaryDark = Color(0xff2bbd7e);
final fructikaSecondary = Colors.deepOrangeAccent.shade200;
final fructikaErrorRed = Colors.redAccent.shade200;

ThemeData buildFructikaTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      appBarTheme: AppBarTheme(elevation: 5),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white70,
        isDense: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(7.5)),
            gapPadding: 5),
      ),
      accentColor: fructikaSecondary,
      primaryColor: fructikaPrimary,
      primaryColorDark: fructikaPrimaryDark,
      primaryColorLight: fructikaPrimaryLight,
      sliderTheme: SliderThemeData.fromPrimaryColors(
          primaryColor: fructikaPrimary,
          primaryColorDark: fructikaPrimaryDark,
          primaryColorLight: fructikaPrimaryLight,
          valueIndicatorTextStyle: base.textTheme.title),
      textTheme: _buildFructikaTextTheme(base.textTheme),
      primaryTextTheme: _buildFructikaTextTheme(base.primaryTextTheme),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: fructikaPrimary,
        textTheme: ButtonTextTheme.normal,
      ),
      toggleableActiveColor: fructikaSecondary,
      textSelectionColor: fructikaPrimary,
      errorColor: fructikaErrorRed);
}

TextTheme _buildFructikaTextTheme(TextTheme base) {
  return base.copyWith().apply(
        displayColor: Colors.black87,
        bodyColor: Colors.black54,
      );
}