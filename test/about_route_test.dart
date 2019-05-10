import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/about_route.dart';
import 'package:fructika/titles.dart';

void main() {
  testWidgets('AboutRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AboutRoute()));

    expect(find.widgetWithText(AppBar, Titles.aboutTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
