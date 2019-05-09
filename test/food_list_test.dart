import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/food_list.dart';
import 'package:fructika/models/food.dart';

void main() {
  final imageName = "group_44723";
  final favouriteFood =
      Food(description: "Orange", favourite: true, foodGroupImage: imageName);
  final unFavouriteFood =
      Food(description: "Pear", favourite: false, foodGroupImage: imageName);

  testWidgets('FoodList', (WidgetTester tester) async {
    // Key so we can manipulate the scaffold
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final foods = [favouriteFood, unFavouriteFood];

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(key: _scaffoldKey, body: FoodList(foods: foods))));

    final listTiles = find.byType(ListTile);

    expect(listTiles, findsNWidgets(foods.length),
        reason: "should show a ListTile for every food");

    final favouriteTile = find.widgetWithText(ListTile, favouriteFood.description);
    expect(find.descendant(of: favouriteTile, matching: find.byIcon(Icons.favorite)), findsOneWidget, reason:"foods that are favourite should have the filled icon");

    final unFavouriteTile = find.widgetWithText(ListTile, unFavouriteFood.description);
    expect(find.descendant(of: unFavouriteTile, matching: find.byIcon(Icons.favorite_border)), findsOneWidget, reason:"foods that are not favourite should have the unfilled icon");
  });
}
