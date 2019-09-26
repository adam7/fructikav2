import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/widgets/favourite_food_icon.dart';
import 'package:fructika/models/food.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockRepository extends Mock implements Repository {}

Widget _buildWidget(Food food, Repository repository) {
  return MultiProvider(providers: [
    Provider<Repository>.value(value: repository),
    //Provider<PreferencesHelper>.value(value: mockPreferencesHelper)
  ], child: MaterialApp(home: Scaffold(body: FavouriteFoodIcon(food: food))));
}

void main() {
  testWidgets('FavouriteFoodIcon when favourite is true',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(_buildWidget(Food(favourite: true), MockRepository()));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
  testWidgets('FavouriteFoodIcon when favourite is false',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(_buildWidget(Food(favourite: false), MockRepository()));

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });

  testWidgets('FavouriteFoodIcon when tapped', (WidgetTester tester) async {
    final mockRepository = MockRepository();

    await tester
        .pumpWidget(_buildWidget(Food(favourite: true), mockRepository));

    await tester.tap(find.byIcon(Icons.favorite));

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget,
        reason: "favourite icon is toggled");
    verify(mockRepository.updateFood(any)).called(1);
  });
}
