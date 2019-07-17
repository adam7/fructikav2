import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/fructose_card.dart';

void main() {
  testWidgets('FructoseCard', (WidgetTester tester) async {
    final food = Food(fructoseValue: 1);

    await tester.pumpWidget(MaterialApp(home: FructoseCard(food)));

    expect(find.widgetWithText(Card, food.fructose.formattedValue), findsOneWidget);
  });
}