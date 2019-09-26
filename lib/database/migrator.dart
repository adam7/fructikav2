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
  static final Migrator _singleton = new Migrator._();
  
  Future<Database> database;
  int version;
  AssetBundle assetBundle;

  final createScripts = [
    SqlCreateBuilder.buildCreateFoodSearch(Platform.isIOS),
    SqlCreateBuilder.createFood,
    SqlCreateBuilder.createFoodGroup
  ];

  Migrator._();

  factory Migrator(Future<Database> database, int version, AssetBundle assetBundle) {
    _singleton.database = database;
    _singleton.version = version;
    _singleton.assetBundle = assetBundle;

    return _singleton;
  }

  Stream<MigrationStatus> migrate() async* {
    yield MigrationStatus(0.1, "Checking status...");

    final runMigrations = await checkIfMigrationsShouldRun();

    if (runMigrations) {
      yield MigrationStatus(0.2, "Creating tables...");
      await createTables(runMigrations);

      yield MigrationStatus(0.4, "Loading foods...");
      await populateFoods(
          runMigrations, await assetBundle.loadString('json/foods.json'));

      yield MigrationStatus(0.8, "Loading food groups...");
      await populateFoodGroups(
          runMigrations, await assetBundle.loadString('json/food_groups.json'));
    }

    yield MigrationStatus(1, "All done");

    return;
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

      final foodCount = Sqflite.firstIntValue(rawQueryResult);

      return foodCount < 1;
    } catch (exception) {
      return true;
    }
  }
}
