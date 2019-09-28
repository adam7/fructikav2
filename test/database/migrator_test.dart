import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/migrator.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'test_data.dart';
import '../mocks.dart';

void main() {
  final List<Map<String, dynamic>> queryResponseCountZero = [
    {"COUNT(*)": 0}
  ];
  final List<Map<String, dynamic>> queryResponseCountOne = [
    {"COUNT(*)": 1}
  ];

  /// These could be so much better but there's no way I know of to run tests with an in memory version of SQLite
  /// To be improved when time or frustration demand
  group("Migrator", () {
    test("createTables when runMigrations is true", () async {
      final db = MockDatabase();
      final migrator = Migrator(Future.value(db), 1, MockAssetBundle());

      await migrator.createTables(true);

      /// Assert that the tables are created
      verify(db.execute(argThat(contains("CREATE VIRTUAL TABLE FoodSearch "))));
      verify(db.execute(argThat(contains("CREATE TABLE Food "))));
      verify(db.execute(argThat(contains("CREATE TABLE FoodGroup "))));
    });

    test("populateFoods when runMigrations is true", () async {
      final db = MockDatabase();
      final batch = MockBatch();
      when(db.batch()).thenReturn(batch);

      final migrator =
          Migrator(Future<Database>.value(db), 1, MockAssetBundle());
      await migrator.populateFoods(true, json.encode(testFoodsJson));

      /// Inserts are called for each food in the json
      /// should check what is being inserted here
      verify(batch.rawInsert(argThat(contains("INSERT Into Food ")), any))
          .called(testFoodsJson.length);
      verify(batch.rawInsert(argThat(contains("INSERT Into FoodSearch ")), any))
          .called(testFoodsJson.length);

      /// Batch is commited
      verify(batch.commit(noResult: true)).called(1);
    });

    test("populateFoodGroups when runMigrations is true", () async {
      final db = MockDatabase();
      final batch = MockBatch();
      when(db.batch()).thenReturn(batch);

      final migrator = Migrator(Future.value(db), 1, MockAssetBundle());

      await migrator.populateFoodGroups(true, json.encode(testFoodGroupsJson));

      /// Inserts are called for each FoodGroup in the json
      /// should check what is being inserted here
      verify(batch.insert('FoodGroup', any)).called(testFoodGroupsJson.length);

      /// Batch is commited
      verify(batch.commit(noResult: true)).called(1);
    });
  });

  group("checkIfMigrationsShouldRun", () {
    test("when foodCount is more than 0", () async {
      final db = MockDatabase();
      when(db.rawQuery(any))
          .thenAnswer((_) => Future.value(queryResponseCountOne));

      final migrator = Migrator(Future.value(db), 1, MockAssetBundle());

      expect(await migrator.checkIfMigrationsShouldRun(), false,
          reason: "should return false");
    });

    test("when foodCount is 0", () async {
      final db = MockDatabase();
      when(db.rawQuery(any))
          .thenAnswer((_) => Future.value(queryResponseCountZero));

      final migrator = Migrator(Future.value(db), 1, MockAssetBundle());

      expect(await migrator.checkIfMigrationsShouldRun(), true,
          reason: "should return true");
    });

    test("when foodCount query throws", () async {
      final db = MockDatabase();

      when(db.rawQuery(any)).thenThrow(Error());
      final migrator = Migrator(Future.value(db), 1, MockAssetBundle());

      expect(await migrator.checkIfMigrationsShouldRun(), true,
          reason: "should return true");
    });
  });

  group("migrate", () {
    test("when running migrate and foods isn't populated", () async {
      final db = MockDatabase();
      when(db.rawQuery(any))
          .thenAnswer((_) => Future.value(queryResponseCountZero));
      when(db.batch()).thenReturn(MockBatch());

      final mockAssetBundle = MockAssetBundle();
      when(mockAssetBundle.loadString(any))
          .thenAnswer((_) => Future.value("[]"));

      final migrator = Migrator(Future.value(db), 1, mockAssetBundle);
      await migrator.migrate();

      expect(
          migrator.stream,
          emitsInOrder([
            isA<MigrationStatus>()
                .having((e) => e.message, "message", "Checking status..."),
            isA<MigrationStatus>()
                .having((e) => e.message, "message", "Creating tables..."),
            isA<MigrationStatus>()
                .having((e) => e.message, "message", "Loading foods..."),
            isA<MigrationStatus>()
                .having((e) => e.message, "message", "Loading food groups..."),
            isA<MigrationStatus>()
                .having((e) => e.message, "message", "All done")
          ]));
    });

    test("when running migrate and foods is populated", () async {
      final db = MockDatabase();
      when(db.rawQuery(any))
          .thenAnswer((_) => Future.value(queryResponseCountOne));

      final migrator = Migrator(Future.value(db), 1, MockAssetBundle());
      await migrator.migrate();

      expect(
          migrator.stream,
          emitsInOrder([
            isA<MigrationStatus>()
                .having((e) => e.message, "message", "Checking status..."),
            isA<MigrationStatus>()
                .having((e) => e.message, "message", "All done")
          ]));
    });
  });
}
