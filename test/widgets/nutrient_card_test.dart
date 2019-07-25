import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/nutrient.dart';
import 'package:fructika/widgets/nutrient_card.dart';

_assertCardAsExpected(Nutrient nutrient, Matcher warningMatcher) {
  final cardFinder = find.byType(Card);
  final titleFinder =
      find.descendant(of: cardFinder, matching: find.text(nutrient.name));
  final valueFinder = find.descendant(
      of: cardFinder, matching: find.text(nutrient.formattedValue));
  final warningIconFinder =
      find.descendant(of: cardFinder, matching: find.byIcon(Icons.warning));

  expect(cardFinder, findsOneWidget);
  expect(titleFinder, findsOneWidget);
  expect(valueFinder, findsOneWidget);
  expect(warningIconFinder, warningMatcher);
}

_buildApp(Nutrient nutrient, {Future<double> warningLevel}) {
  return MaterialApp(home: NutrientCard(nutrient, warningLevel: warningLevel));
}

_runTestAsync(WidgetTester tester, Nutrient nutrient, Matcher warningMatcher,
    {Future<double> warningLevel}) async {
  await tester.runAsync(() async {
    await tester.pumpWidget(_buildApp(nutrient, warningLevel: warningLevel));

    await tester.pumpAndSettle();

    _assertCardAsExpected(nutrient, warningMatcher);
  });
}

void main() {
  final nutrientWithLevelTen = Nutrient("Nutrient", 10);

  testWidgets('NutrientCard without warning level',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp(nutrientWithLevelTen));

    await _runTestAsync(tester, nutrientWithLevelTen, findsNothing);
  });

  testWidgets('NutrientCard with warning level and value below it',
      (WidgetTester tester) async {
    final warningLevel = Future.value(11.0);

    await _runTestAsync(tester, nutrientWithLevelTen, findsNothing,
        warningLevel: warningLevel);
  });

  testWidgets('NutrientCard with warning level and value above it',
      (WidgetTester tester) async {
    final warningLevel = Future.value(9.0);

    await _runTestAsync(tester, nutrientWithLevelTen, findsOneWidget,
        warningLevel: warningLevel);
  });

  testWidgets('NutrientCard with warning level and null value',
      (WidgetTester tester) async {
    final nutrientWithNullValue = Nutrient("Nutrient with null", null);
    final warningLevel = Future.value(9.0);

    await _runTestAsync(tester, nutrientWithNullValue, findsNothing,
        warningLevel: warningLevel);
  });
}
