import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/about_route.dart';
import 'package:fructika/utilities/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

MethodChannel channel = const MethodChannel('plugins.flutter.io/url_launcher');

void main() {
  List<String> launchLog;

  setUp(() async {
    launchLog = <String>[];

    // Register the mock launch handler
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'launch') {
        launchLog.add(methodCall.arguments["url"]);
      }
    });
  });

  tearDown(() async {
    // Unregister the mock launch handler
    channel.setMockMethodCallHandler(null);
  });

  testWidgets('AboutRoute', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AboutRoute()));

    final appBarFinder = find.widgetWithText(FructikaAppBar, Titles.aboutTitle);
    final faqFinder = find.byType(FaqWidget);
    final twitterIconFinder =
        find.descendant(of: faqFinder, matching: find.byIcon(MdiIcons.twitter));
    final creditExpansionTileFinder =
        find.widgetWithText(ExpansionTile, "Photo credits", skipOffstage: false);
    final creditListTileFinder = find.descendant(
        of: creditExpansionTileFinder,
        matching: find.byType(ListTile, skipOffstage: false), skipOffstage: false);

    expect(appBarFinder, findsOneWidget,
        reason: "app bar should have the right title");
    expect(faqFinder, findsNWidgets(6), reason: "There should be 6 FAQs");

    await tester.tap(twitterIconFinder);

    expect(launchLog.contains("https://twitter.com/adm_cpr"), isTrue,
        reason: "Clicking the icon in a FAQ should launch it's url");

    await tester.ensureVisible(creditExpansionTileFinder);
    await tester.tap(creditExpansionTileFinder);
    await tester.pumpAndSettle();

    expect(creditListTileFinder, findsWidgets,
        reason:
            "After expanding credits there should be a list tile for every credit");
  });
}
