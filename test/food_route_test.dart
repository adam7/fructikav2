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
    dietaryFiberValue: 1.0,
    fructoseValue: 1.0,
    glucoseValue: 1.0,
    maltoseValue: 1.0,
    sucroseValue: 1.0,
    totalSugarsValue: 4.0,
    lactoseValue: 1.0,
    proteinValue: 1.0
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
  });
}
