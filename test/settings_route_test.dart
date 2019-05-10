import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/settings_route.dart';
import 'package:fructika/titles.dart';

void main() {
  testWidgets('SettingsRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SettingsRoute()));

    expect(find.widgetWithText(AppBar, Titles.settingsTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
