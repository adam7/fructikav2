import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/startup_route.dart';
import 'package:fructika/widgets/startup_background.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'mocks.dart';

void main() {
  testWidgets('StartupRoute', (WidgetTester tester) async {
    final mockRepository = MockRepository();
    final mockDatabase = MockDatabase();

    when(mockRepository.database)
        .thenAnswer((_) async => Future.value(mockDatabase));

    await tester.runAsync(() async {
      await tester.pumpWidget(MultiProvider(
          providers: [Provider<Repository>.value(value: mockRepository)],
          child: MaterialApp(home: StartupRoute())));

      expect(find.byType(StartupBackground), findsOneWidget);
    });
  });
}
