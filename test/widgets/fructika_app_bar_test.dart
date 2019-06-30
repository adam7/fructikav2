import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';

void main() {
  testWidgets("FructikaAppBar with title", (WidgetTester tester) async {
    final titleWidget = Text("Title Text");

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(appBar: FructikaAppBar(title: titleWidget))));

    expect(find.byWidget(titleWidget), findsOneWidget,
        reason: "title should be shown");
  });
}
