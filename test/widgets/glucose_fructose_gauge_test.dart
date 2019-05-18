import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/glucose_fructose_gauge.dart';

void main() {
  testWidgets('GlucoseFructoseGauge', (WidgetTester tester) async {
    final food = Food(glucose: 1.5, fructose: 3.3);

    await tester.pumpWidget(MaterialApp(home: GlucoseFructoseGauge(food)));

    expect(find.byType(GlucoseFructoseGauge), findsOneWidget);
  });
}