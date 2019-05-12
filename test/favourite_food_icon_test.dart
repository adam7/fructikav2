import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/database_provider.dart';
import 'package:fructika/favourite_food_icon.dart';
import 'package:fructika/models/food.dart';
import 'package:mockito/mockito.dart';

class MockDatabaseProvider extends Mock implements DatabaseProvider {}

MaterialApp _buildWidget(Food food, DatabaseProvider databaseProvider) {
  return MaterialApp(
      home: Scaffold(
          body: FavouriteFoodIcon(
              food: food, databaseProvider: databaseProvider)));
}

void main() {
  testWidgets('FavouriteFoodIcon when favourite is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        _buildWidget(Food(favourite: true), MockDatabaseProvider()));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
  testWidgets('FavouriteFoodIcon when favourite is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        _buildWidget(Food(favourite: false), MockDatabaseProvider()));

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });

  testWidgets('FavouriteFoodIcon when tapped', (WidgetTester tester) async {
    final mockDatabaseProvider = MockDatabaseProvider();

    await tester.pumpWidget(
        _buildWidget(Food(favourite: true), mockDatabaseProvider));

    await tester.tap(find.byIcon(Icons.favorite));

    await tester.pump();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget, reason: "favourite icon is toggled");
    verify(mockDatabaseProvider.updateFood(any)).called(1);
  });
}
