import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/favourites_route.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';

void main() {
  testWidgets('FavouritesRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FavouritesRoute()));

    expect(find.widgetWithText(FructikaAppBar, Titles.favouriteTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
