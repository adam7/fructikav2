import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/migrations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'test_data.dart';

class MockDatabase extends Mock implements Database {}

class MockBatch extends Mock implements Batch {}

void main() {
  /// These could be so much better but there's no way I know of to run tests with an in memory version of SQLite
  /// To be improved when time or frustration demand
  group("Database migrations", () {
    test("createTables", () async {
      final db = MockDatabase();

      await createTables(db, 1);

      /// Assert that the tables are created
      verify(db.execute(argThat(contains("CREATE VIRTUAL TABLE FoodSearch "))));
      verify(db.execute(argThat(contains("CREATE TABLE Food "))));
      verify(db.execute(argThat(contains("CREATE TABLE FoodGroup "))));
    });

    test("populateFoods", () async {
      final db = MockDatabase();
      final batch = MockBatch();

      when(db.batch()).thenReturn(batch);

      populateFoods(db, json.encode(testFoodsJson));

      /// Inserts are called for each food in the json
      /// should check what is being inserted here 
      verify(batch.rawInsert(argThat(contains("INSERT Into Food ")), any))
           .called(testFoodsJson.length);      
      verify(batch.rawInsert(argThat(contains("INSERT Into FoodSearch ")), any))
          .called(testFoodsJson.length);

      /// Batch is commited
      verify(batch.commit(noResult: true)).called(1);
    });

    test("populateFoodGroups", () async {
      final db = MockDatabase();
      final batch = MockBatch();

      when(db.batch()).thenReturn(batch);

      populateFoodGroups(db, json.encode(testFoodGroupsJson));

      /// Inserts are called for each FoodGroup in the json
      /// should check what is being inserted here
      verify(batch.insert('FoodGroup', any)).called(testFoodGroupsJson.length);

      /// Batch is commited
      verify(batch.commit(noResult: true)).called(1);
    });
  });
}
