import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/sugars_card.dart';

final imageName = "group_44723";
final testFood = Food(
    description: "Test Food",
    favourite: true,
    foodGroupImage: imageName,
    foodGroup: "Test Group",
    totalSugarsValue: 4,
    fructoseValue: 1,
    glucoseValue: 1,
    sucroseValue: 1,
    maltoseValue: 1);

void main() {
  testWidgets('SugarsCard', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SugarsCard(testFood)));

    _rowContainsSugarNameAndValue(0, "Total Sugars", "4.00g");
    _rowContainsSugarNameAndValue(1, "Fructose", "1.00g");
    _rowContainsSugarNameAndValue(2, "Glucose", "1.00g");
    _rowContainsSugarNameAndValue(3, "Sucrose", "1.00g");
    _rowContainsSugarNameAndValue(4, "Maltose", "1.00g");
  });

  group("SugarRow", () {
    testWidgets('SugarRow with name and value shows a Row with name and formatted value', (WidgetTester tester) async {
      final nutrientName = "Nutrient Name";
      final nutrientValue = 5;

      await tester.pumpWidget(
          MaterialApp(home: SugarRow(Nutrient(nutrientName, nutrientValue))));

      _rowContainsSugarNameAndValue(0, nutrientName, "$nutrientValue.00g");
    });

     testWidgets('SugarRow with name and null value shows a Row with name and question mark for value', (WidgetTester tester) async {
      final nutrientName = "Nutrient Name";

      await tester.pumpWidget(
          MaterialApp(home: SugarRow(Nutrient(nutrientName, null))));

      
      _rowContainsSugarNameAndValue(0, nutrientName, "?g");
    });
  });
}

_rowContainsSugarNameAndValue(num index, String name, String value) {
  final rowFinder = find.byType(Row).at(index);

  expect(
      find.descendant(of: rowFinder, matching: find.text(name)), findsOneWidget,
      reason: "Row contains '$name' sugar name");
  expect(find.descendant(of: rowFinder, matching: find.text(value)),
      findsOneWidget,
      reason: "Row contains formatted sugar value");
}
