import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/sugars_chart.dart';

void main() {
  testWidgets('SugarsChart', (WidgetTester tester) async {
    final food = Food(glucoseValue: 1.5, fructoseValue: 3.3, maltoseValue: 1.1, sucroseValue: 2.5, totalSugarsValue: 8.4);

    await tester.pumpWidget(MaterialApp(home: SugarsChart(food)));

    expect(find.byType(SugarsChart), findsOneWidget);
  });
}