import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/food_route.dart';
import 'test_utils.dart';

/// This file doesn't follow naming conventions because if it has the right file 
/// name our CI build fails 🤷‍
void main() {
  testWidgets('FoodRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FoodRoute(food: favouriteFood)));
    
    expect(find.text(favouriteFood.description), findsOneWidget,
        reason: "food description should be shown");
    expect(find.text(favouriteFood.foodGroup), findsOneWidget,
        reason: "food group name should be shown");
    expect(find.byIcon(Icons.favorite), findsOneWidget,
        reason: "favourite food should have the filled icon");
  });
}
