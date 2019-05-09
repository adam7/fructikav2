import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/models/food_group.dart';
import 'package:sqflite/sqflite.dart';

class Migrator {
  Future<void> create(Database db) async {
    await createTables(db);
    await populateTables(db);
  }

  createTables(Database db) async {
    await _createFoodTable(db);
    await _createFoodSearchTable(db);
    await _createFoodGroupTable(db);
  }

  populateTables(Database db) async {
    await _populateFoods(db);
    await _populateFoodGroups(db);
  }

  _createFoodSearchTable(Database db) async {
    await db.execute("CREATE VIRTUAL TABLE FoodSearch using fts4("
        "id TEXT,"
        "description TEXT,"
        "notindexed=id"
        ")");
  }

  _createFoodTable(Database db) async {
    await db.execute("CREATE TABLE Food ("
        "id TEXT PRIMARY KEY,"
        "description TEXT,"
        "food_group TEXT,"
        "food_group_image TEXT,"
        "protein REAL,"
        "total_sugars REAL,"
        "sucrose REAL,"
        "glucose REAL,"
        "fructose REAL,"
        "lactose REAL,"
        "maltose REAL,"
        "dietaryFiber REAL,"
        "favourite BIT"
        ")");
  }

  _createFoodGroupTable(Database db) async {
    await db.execute("CREATE TABLE FoodGroup ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "image TEXT,"
        "enabled BIT"
        ")");
  }

  _populateFoods(Database db) async {
    List<Food> foods = List<Food>();
    final foodsJSON = await rootBundle.loadString('json/foods.json');

    for (final foodJSON in json.decode(foodsJSON)) {
      foods.add(Food.fromMap(foodJSON));
    }

    final batch = db.batch();

    for (var food in foods) {
      batch.rawInsert(
          "INSERT Into Food (id, description, food_group, food_group_image, favourite,"
          " protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietaryFiber)"
          " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            food.id,
            food.description,
            food.foodGroup,
            food.foodGroupImage,
            food.favourite,
            food.protein,
            food.totalSugars,
            food.sucrose,
            food.glucose,
            food.fructose,
            food.lactose,
            food.maltose,
            food.dietaryFiber
          ]);

      batch.rawInsert(
          "INSERT Into FoodSearch (id,description)"
          " VALUES (?,?)",
          [
            food.id,
            food.description,
          ]);
    }

    await batch.commit(noResult: true);
  }

  _populateFoodGroups(Database db) async {
    List<FoodGroup> foodGroups = List<FoodGroup>();

    final foodGroupsJSON = await rootBundle.loadString('json/food_groups.json');

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
}
