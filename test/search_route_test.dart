import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/database_provider.dart';
import 'package:fructika/favourite_food_icon.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/search_route.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockDatabaseProvider extends Mock implements DatabaseProvider {}
class MockPreferencesHelper extends Mock implements PreferencesHelper {}

final imageName = "group_44723";

final pea = Food(
    description: "Pea",
    favourite: true,
    foodGroupImage: imageName,
    foodGroup: "Fruit");
final peach = Food(
    description: "Peach",
    favourite: false,
    foodGroupImage: imageName,
    foodGroup: "Fruit");
final pear = Food(
    description: "Pear",
    favourite: false,
    foodGroupImage: imageName,
    foodGroup: "Fruit");

void main() {
  testWidgets('SearchRoute default layout', (WidgetTester tester) async {
    final mockDatabaseProvider = MockDatabaseProvider();
    final mockPreferencesHelper = MockPreferencesHelper();

    await tester.pumpWidget(Provider<PreferencesHelper>.value(
      value: mockPreferencesHelper,
      child: MaterialApp(home: SearchRoute(mockDatabaseProvider)),
    ));

    expect(find.widgetWithText(FructikaAppBar, Titles.foodSearchTitle), findsOneWidget,
        reason: "app bar should have the right title");

    expect(
        find.widgetWithText(TextField, Titles.foodSearchTitle), findsOneWidget,
        reason: "should have a text input for searching");

    expect(find.byType(TextField), findsOneWidget,
        reason: "should have only one text input");
  });

  testWidgets('SearchRoute when searching with less than minimum characters',
      (WidgetTester tester) async {
    final mockDatabaseProvider = MockDatabaseProvider();
    final mockPreferencesHelper = MockPreferencesHelper();

    await tester.pumpWidget(Provider<PreferencesHelper>.value(
      value: mockPreferencesHelper,
      child: MaterialApp(home: SearchRoute(mockDatabaseProvider)),
    ));

    await tester.enterText(find.byType(TextField), 'p');
    await tester.enterText(find.byType(TextField), 'pe');

    /// Tap search to trigger the submit event
    await tester.testTextInput.receiveAction(TextInputAction.search);

    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNothing,
        reason: "no results should be shown");
    verifyNever(mockDatabaseProvider.searchFoods(any, any));
  });

  testWidgets('SearchRoute when searching with more than minimum characters',
      (WidgetTester tester) async {
    final peaText = "pea";
    final peaResults = [pea, pear, peach];
    final pearText = "pear";
    final pearResults = [pear];

    final mockDatabaseProvider = MockDatabaseProvider();
    final mockPreferencesHelper = MockPreferencesHelper();

    when(mockDatabaseProvider.searchFoods(peaText, any))
        .thenAnswer((_) async => Future.value(peaResults));
    when(mockDatabaseProvider.searchFoods(pearText, any))
        .thenAnswer((_) async => Future.value(pearResults));

    await tester.pumpWidget(Provider<PreferencesHelper>.value(
      value: mockPreferencesHelper,
      child: MaterialApp(home: SearchRoute(mockDatabaseProvider)),
    ));

    await tester.enterText(find.byType(TextField), peaText);
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(peaResults.length),
        reason: "searching for $peaText should render ${peaResults.length} results");

    await tester.enterText(find.byType(TextField), pearText);
    await tester.pumpAndSettle();    

    final listTileFinder = find.byType(ListTile);
    expect(listTileFinder, findsNWidgets(pearResults.length),
        reason: "searching for $pearText should render ${pearResults.length} results");
    
    for (var result in pearResults) {
      expect(find.descendant(of: listTileFinder, matching: find.text(result.description)), findsOneWidget);
      expect(find.descendant(of: listTileFinder, matching: find.byType(FavouriteFoodIcon)), findsOneWidget);
      expect(find.descendant(of: listTileFinder, matching: find.byType(CircleAvatar)), findsOneWidget);
    }
  });
}
