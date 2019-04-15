import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/app_drawer.dart';

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
    
    expect(find.descendant(of: listTiles, matching: find.text("Food Groups")), findsOneWidget);
    expect(find.descendant(of: listTiles, matching: find.text("Food Search")), findsOneWidget);
    expect(find.descendant(of: listTiles, matching: find.text("Settings")), findsOneWidget);
    expect(find.descendant(of: listTiles, matching: find.text("About")), findsOneWidget);
    expect(find.descendant(of: listTiles, matching: find.text("Favourites")), findsOneWidget);
  });
}
