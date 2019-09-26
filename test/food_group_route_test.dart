import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/food_group_route.dart';
import 'package:fructika/models/food_group.dart';
import 'package:fructika/utilities/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'mocks.dart';

void main() {
  final FoodGroup enabledFoodGroup = FoodGroup(
      name: "Enabled Food Group",
      enabled: true,
      image: "images/group_156096.jpg");

  final List<FoodGroup> foodGroups = [enabledFoodGroup];

  testWidgets('FoodGroupRoute without FoodGroups', (WidgetTester tester) async {
    final MockRepository mockRepository = MockRepository();

    await tester.pumpWidget(Provider<Repository>.value(
      value: mockRepository,
      child: MaterialApp(home: FoodGroupRoute()),
    ));

    expect(find.widgetWithText(FructikaAppBar, Titles.foodGroupTitle),
        findsOneWidget,
        reason: "AppBar should have the right title");

    expect(find.byType(CircularProgressIndicator), findsOneWidget,
        reason: "ProgressIndicator should be shown");
  });

  testWidgets('FoodGroupRoute with FoodGroups', (WidgetTester tester) async {
    final mockRepository = MockRepository();

    when(mockRepository.getAllFoodGroups())
        .thenAnswer((_) async => Future.value(foodGroups));

    await tester.pumpWidget(Provider<Repository>.value(
      value: mockRepository,
      child: MaterialApp(home: FoodGroupRoute()),
    ));

    await tester.pump(const Duration(milliseconds: 1000));

    expect(find.widgetWithText(FructikaAppBar, Titles.foodGroupTitle),
        findsOneWidget,
        reason: "AppBar should have the right title");

    final cardFinder = find.byType(Card);
    final switchListTileFinder =
        find.widgetWithText(SwitchListTile, enabledFoodGroup.name);
    final switchFinder = find.byWidgetPredicate(
      (widget) => widget is Switch && widget.value == enabledFoodGroup.enabled,
      description: 'Switch is enabled',
    );

    expect(find.descendant(of: cardFinder, matching: switchListTileFinder),
        findsOneWidget,
        reason: "Card contains SwitchListTile with the food group name");
    expect(
        find.descendant(of: cardFinder, matching: switchFinder), findsOneWidget,
        reason: "Card contains Switch");
    expect(find.descendant(of: cardFinder, matching: find.byType(Image)),
        findsOneWidget);
    expect(find.byType(Image), findsOneWidget, reason: "Card contains Image");
  });

  testWidgets(
      'FoodGroupRoute when switching FoodGroup from enabled to disabled',
      (WidgetTester tester) async {
    final mockRepository = MockRepository();

    final enabledSwitchListTileFinder =
        find.widgetWithText(SwitchListTile, "Enabled");
    final disabledSwitchListTileFinder =
        find.widgetWithText(SwitchListTile, "Disabled");

    when(mockRepository.getAllFoodGroups())
        .thenAnswer((_) async => Future.value(foodGroups));

    await tester.pumpWidget(Provider<Repository>.value(
      value: mockRepository,
      child: MaterialApp(home: FoodGroupRoute()),
    ));

    await tester.pump(const Duration(milliseconds: 1000));

    expect(enabledSwitchListTileFinder, findsOneWidget,
        reason: "SwitchListTile has text Enabled");

    await tester.tap(enabledSwitchListTileFinder);
    await tester.pump();

    expect(disabledSwitchListTileFinder, findsOneWidget,
        reason: "SwitchListTile has text Disabled");
  });
}
