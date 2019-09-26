import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/widgets/food_list.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../test_utils.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  testWidgets('FoodList', (WidgetTester tester) async {
    // Key so we can manipulate the scaffold
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final foods = [TestFoodData.favouriteFood, TestFoodData.unFavouriteFood];

    await tester.pumpWidget(Provider<Repository>.value(
      value: MockRepository(),
      child: MaterialApp(
          home: Scaffold(key: _scaffoldKey, body: FoodList(foods: foods))),
    ));

    final listTiles = find.byType(ListTile);

    expect(listTiles, findsNWidgets(foods.length),
        reason: "should show a ListTile for every food");

    final favouriteTile =
        find.widgetWithText(ListTile, TestFoodData.favouriteFood.description);

    expect(
        find.descendant(
            of: favouriteTile, matching: find.byIcon(Icons.favorite)),
        findsOneWidget,
        reason: "foods that are favourite should have the filled icon");

    final unFavouriteTile =
        find.widgetWithText(ListTile, TestFoodData.unFavouriteFood.description);

    expect(
        find.descendant(
            of: unFavouriteTile, matching: find.byIcon(Icons.favorite_border)),
        findsOneWidget,
        reason: "foods that are not favourite should have the unfilled icon");
  });
}
