import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/nutrient_card.dart';

void main() {
  testWidgets('NutrientCard', (WidgetTester tester) async {
    final nutrient = Nutrient("Nutrient", 1);

    await tester.pumpWidget(MaterialApp(home: NutrientCard(nutrient)));

    final cardFinder = find.byType(Card);
    final titleFinder =
        find.descendant(of: cardFinder, matching: find.text(nutrient.name));
    final valueFinder = find.descendant(
        of: cardFinder, matching: find.text(nutrient.formattedValue));

    expect(cardFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    expect(valueFinder, findsOneWidget);
  });
}
