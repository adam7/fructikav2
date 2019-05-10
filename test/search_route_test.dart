import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/search_route.dart';
import 'package:fructika/titles.dart';

void main() {
  testWidgets('SearchRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SearchRoute()));

    expect(find.widgetWithText(AppBar, Titles.foodSearchTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
