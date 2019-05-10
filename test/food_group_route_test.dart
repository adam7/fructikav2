import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/food_group_route.dart';
import 'package:fructika/titles.dart';

void main() {
  testWidgets('FoodRoute', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: FoodGroupRoute()));

    expect(find.widgetWithText(AppBar, Titles.foodGroupTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
