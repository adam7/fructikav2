import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/food_route.dart';
import 'test_utils.dart';

void main() {
  testWidgets('FoodRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FoodRoute(food: TestFoodData.favouriteFood)));

    expect(find.text(TestFoodData.favouriteFood.description), findsOneWidget,
        reason: "food description should be shown");
    expect(find.text(TestFoodData.favouriteFood.foodGroup), findsOneWidget,
        reason: "food group name should be shown");
    expect(find.byIcon(Icons.favorite), findsOneWidget,
        reason: "favourite food should have the filled icon");
  }, skip: true);
}
