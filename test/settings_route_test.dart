import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/settings_route.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';
import 'package:mockito/mockito.dart';

  class MockPreferencesHelper extends Mock implements PreferencesHelper{}

void main() {
  testWidgets('SettingsRoute', (WidgetTester tester) async {
    final mockPreferencesHelper = MockPreferencesHelper(); 
    final expectedShowUnknown = true;

    when(mockPreferencesHelper.getShowUnknown()).thenAnswer((_) => Future.value(expectedShowUnknown));
    when(mockPreferencesHelper.getWarningLevel()).thenAnswer((_) => Future.value(10));

    await tester.pumpWidget(MaterialApp(home: SettingsRoute(preferencesHelper: MockPreferencesHelper() )));

    expect(find.widgetWithText(AppBar, Titles.settingsTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
