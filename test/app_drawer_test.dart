import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/titles.dart';

void main() {
  testWidgets('App drawer has all the right menu items',
      (WidgetTester tester) async {
    // Key so we can manipulate the scaffold
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
        MaterialApp(home: Scaffold(key: _scaffoldKey, drawer: AppDrawer())));

    _scaffoldKey.currentState.openDrawer();

    await tester.pump();

    final listTiles = find.byType(ListTile);
    
    expect(find.descendant(of: listTiles, matching: find.text(Titles.foodGroupTitle)), findsOneWidget);
    expect(find.descendant(of: listTiles, matching: find.text(Titles.foodSearchTitle)), findsOneWidget);
    expect(find.descendant(of: listTiles, matching: find.text(Titles.settingsTitle)), findsOneWidget);
    expect(find.descendant(of: listTiles, matching: find.text(Titles.aboutTitle)), findsOneWidget);
    expect(find.descendant(of: listTiles, matching: find.text(Titles.favouriteTitle)), findsOneWidget);
  });
}
