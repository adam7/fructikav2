import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fructika/database/sql_create_builder.dart';
import 'package:fructika/database/sql_insert_builder.dart';
import 'package:fructika/database/sql_select_builder.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/models/food_group.dart';
import 'package:sqflite/sqflite.dart';

class MigrationStatus {
  final double percentComplete;
  final String message;

  MigrationStatus(this.percentComplete, this.message);
}

class Migrator {
  final _streamController = StreamController<MigrationStatus>();
  final Future<Database> database;
  final int version;
  final AssetBundle assetBundle;
  final createScripts = [
    SqlCreateBuilder.buildCreateFoodSearch(Platform.isIOS),
    SqlCreateBuilder.createFood,
    SqlCreateBuilder.createFoodGroup
  ];

  Stream<MigrationStatus> get stream {
    return _streamController.stream;
  }

  Migrator(this.database, this.version, this.assetBundle);

  Future<void> migrate() async {
    _streamController.add(MigrationStatus(0.1, "Checking status..."));
    final runMigrations = await checkIfMigrationsShouldRun();

    if (runMigrations) {
      _streamController.add(MigrationStatus(0.2, "Creating tables..."));
      await createTables(runMigrations);

      _streamController.add(MigrationStatus(0.4, "Loading foods..."));
      await populateFoods(
          runMigrations, await assetBundle.loadString('json/foods.json'));

      _streamController.add(MigrationStatus(0.8, "Loading food groups..."));
      await populateFoodGroups(
          runMigrations, await assetBundle.loadString('json/food_groups.json'));
    }

    _streamController.add(MigrationStatus(1, "All done"));

    _streamController.close();
  }

  createTables(bool runMigrations) async {
    final db = await database;
    createScripts.forEach((script) async => await db.execute(script));
  }

  populateFoods(bool runMigrations, String foodsJSON) async {
    final db = await database;
    List<Food> foods = List<Food>();

    for (final foodJSON in json.decode(foodsJSON)) {
      foods.add(Food.fromMap(foodJSON));
    }

    final batch = db.batch();

    for (var food in foods) {
      batch.rawInsert(SqlInsertBuilder.foodInsert, [
        food.id,
        food.description,
        food.foodGroup,
        food.foodGroupImage,
        food.favourite,
        food.protein.value,
        food.totalSugars.value,
        food.sucrose.value,
        food.glucose.value,
        food.fructose.value,
        food.lactose.value,
        food.maltose.value,
        food.dietaryFiber.value
      ]);

      batch.rawInsert(SqlInsertBuilder.foodSearchInsert, [
        food.id,
        food.description,
      ]);
    }

    await batch.commit(noResult: true);
  }

  populateFoodGroups(bool runMigrations, String foodGroupsJSON) async {
    final db = await database;
    List<FoodGroup> foodGroups = List<FoodGroup>();

    for (final foodGroupJSON in json.decode(foodGroupsJSON)) {
      foodGroups.add(FoodGroup.fromMap(foodGroupJSON));
    }

    final batch = db.batch();

    for (var foodGroup in foodGroups) {
      batch.insert('FoodGroup', {
        "id": foodGroup.id,
        "name": foodGroup.name,
        "image": foodGroup.image,
        "enabled": 1
      });
    }

    await batch.commit(noResult: true);
  }

  Future<bool> checkIfMigrationsShouldRun() async {
    final db = await database;

    try {
      final rawQueryResult = await db.rawQuery(SqlSelectBuilder.foodCountQuery);

      return Sqflite.firstIntValue(rawQueryResult) < 1;
    } catch (exception) {
      return true;
    }
  }
}
