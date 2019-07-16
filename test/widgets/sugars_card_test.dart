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
  testWidgets('AboutRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SugarsCard(testFood)));

  });
}
