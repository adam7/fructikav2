import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/favourites_route.dart';
import 'package:fructika/titles.dart';

void main() {
  testWidgets('FavouritesRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FavouritesRoute()));

    expect(find.widgetWithText(AppBar, Titles.favouriteTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
