import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/glucose_fructose_gauge.dart';

void main() {
  testWidgets('GlucoseFructoseGauge with values for fructose and glucose', (WidgetTester tester) async {
    final food = Food(glucoseValue: 1.5, fructoseValue: 3.3);

    await tester.pumpWidget(MaterialApp(home: GlucoseFructoseGauge(food)));

    expect(find.byType(PieChart), findsOneWidget, reason: "Renders a PieChart");
  });
  
  testWidgets('GlucoseFructoseGauge with value for fructose and null for glucose', (WidgetTester tester) async {
    final food = Food(fructoseValue: 3.3);

    await tester.pumpWidget(MaterialApp(home: GlucoseFructoseGauge(food)));

    expect(find.byType(PieChart), findsNothing);
  });
  
  testWidgets('GlucoseFructoseGauge with value for glucose and null for fructose', (WidgetTester tester) async {
    final food = Food(glucoseValue: 3.3);

    await tester.pumpWidget(MaterialApp(home: GlucoseFructoseGauge(food)));

    expect(find.byType(PieChart), findsNothing);
  });
}