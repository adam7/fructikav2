import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/favourite_food_icon.dart';
import 'package:fructika/food_route.dart';
import 'package:fructika/models/food.dart';

final imageName = "group_44723";
final testFood = Food(
    description: "Test Food",
    favourite: true,
    foodGroupImage: imageName,
    foodGroup: "Test Group",
    dietaryFiberValue: 1,
    fructoseValue: 1,
    glucoseValue: 1,
    maltoseValue: 1,
    sucroseValue: 1,
    totalSugarsValue: 4,
    lactoseValue: 1,
    proteinValue: 1
    );

void main() {
  /// Skipping until we can get charts rendering in the 
  testWidgets('FoodRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FoodRoute(food: testFood)));

    expect(find.text(testFood.description), findsOneWidget,
        reason: "food description should be shown");
    expect(find.text(testFood.foodGroup), findsOneWidget,
        reason: "food group name should be shown");
    expect(find.byType(FavouriteFoodIcon), findsOneWidget,
        reason: "favourite food icon widget should be shown");
  }, skip: true);
}
