import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/favourites_route.dart';
import 'package:fructika/utilities/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:provider/provider.dart';

import 'mocks.dart';


void main() {
  testWidgets('FavouritesRoute', (WidgetTester tester) async {

    await tester.pumpWidget(Provider<Repository>.value(
      value: MockRepository(),
      child: MaterialApp(home: FavouritesRoute()),
    ));

    expect(find.widgetWithText(FructikaAppBar, Titles.favouriteTitle), findsOneWidget,
        reason: "app bar should have the right title");
  });
}
