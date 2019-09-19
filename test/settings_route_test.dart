import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/settings_route.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockPreferencesHelper extends Mock implements PreferencesHelper {}

void main() {
  testWidgets('SettingsRoute', (WidgetTester tester) async {
    final mockPreferencesHelper = MockPreferencesHelper();
    final expectedShowUnknown = true;

    when(mockPreferencesHelper.getShowUnknown())
        .thenAnswer((_) => Future.value(expectedShowUnknown));
    when(mockPreferencesHelper.getWarningLevel())
        .thenAnswer((_) => Future.value(10));

    await tester.pumpWidget(Provider<PreferencesHelper>.value(
      value: mockPreferencesHelper,
      child: MaterialApp(home: SettingsRoute()),
    ));

    expect(find.widgetWithText(FructikaAppBar, Titles.settingsTitle),
        findsOneWidget,
        reason: "app bar should have the right title");
    expect(find.byType(WarningLevelSlider), findsOneWidget,
        reason: "Warning Level selector should be shown");
    expect(find.byType(ShowUnknownSwitchListTile), findsOneWidget,
        reason: "Show Unknown selector should be shown");
  });

  group("WarningLevelDropdownListTile", () {
    testWidgets("when no value is returned a ProgressIndicator is shown",
        (WidgetTester tester) async {
      final mockPreferencesHelper = MockPreferencesHelper();

      await tester.pumpWidget(Provider<PreferencesHelper>.value(
        value: mockPreferencesHelper,
        child: WarningLevelSlider(),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        "when a value is returned a WarningLevelDropdownListTile is shown",
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final mockPreferencesHelper = MockPreferencesHelper();

        final warningLevel = 10.0;

        when(mockPreferencesHelper.getWarningLevel())
            .thenAnswer((_) async => Future.value(warningLevel));

        await tester.pumpWidget(Provider<PreferencesHelper>.value(
          value: mockPreferencesHelper,
          child: MaterialApp(home: Scaffold(body: WarningLevelSlider())),
        ));

        await tester.pumpAndSettle();

        expect(find.byType(WarningLevelSlider), findsOneWidget);
        expect(
            find.byWidgetPredicate(
                (widget) => widget is Slider && widget.value == warningLevel),
            findsOneWidget);
      });
    });
  });

  group("ShowUnknownSwitchListTile", () {
    testWidgets("when no value is returned a ProgressIndicator is shown",
        (WidgetTester tester) async {
      final mockPreferencesHelper = MockPreferencesHelper();

      await tester.pumpWidget(Provider<PreferencesHelper>.value(
        value: mockPreferencesHelper,
        child: ShowUnknownSwitchListTile(),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("when a value is returned a SwitchListTile is shown",
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final mockPreferencesHelper = MockPreferencesHelper();

        when(mockPreferencesHelper.getShowUnknown())
            .thenAnswer((_) async => Future.value(true));

        await tester.pumpWidget(Provider<PreferencesHelper>.value(
          value: mockPreferencesHelper,
          child: MaterialApp(home: Scaffold(body: ShowUnknownSwitchListTile())),
        ));

        await tester.pumpAndSettle();

        expect(
            find.byWidgetPredicate(
                (widget) => widget is SwitchListTile && widget.value == true),
            findsOneWidget);
      });
    });
  });
}
