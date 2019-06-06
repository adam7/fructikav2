import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/database_provider.dart';
import 'package:fructika/food_group_route.dart';
import 'package:fructika/models/food_group.dart';
import 'package:fructika/titles.dart';
import 'package:mockito/mockito.dart';

class MockDatabaseProvider extends Mock implements DatabaseProvider {}

void main() {
  testWidgets('FoodGroupRoute', (WidgetTester tester) async {
    final List<FoodGroup> foodGroups = [FoodGroup(name: "Group 1", enabled: true)];
    final MockDatabaseProvider mockDatabaseProvider = MockDatabaseProvider();

    when(mockDatabaseProvider.getAllFoodGroups())
        .thenAnswer((_) => Future.value(foodGroups));

    await tester
        .pumpWidget(MaterialApp(home: FoodGroupRoute(mockDatabaseProvider)));

    expect(find.widgetWithText(AppBar, Titles.foodGroupTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
