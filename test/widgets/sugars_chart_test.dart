import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/sugars_chart.dart';

void main() {
  testWidgets('SugarsChart', (WidgetTester tester) async {
    final food = Food(glucose: 1.5, fructose: 3.3, maltose: 1.1, sucrose: 2.5, totalSugars: 8.4);

    await tester.pumpWidget(MaterialApp(home: SugarsChart(food)));

    expect(find.byType(SugarsChart), findsOneWidget);
  });
}