import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/models/food_group.dart';
import 'package:sqflite/sqflite.dart';

final createFoodSearch =
    "CREATE VIRTUAL TABLE FoodSearch using fts4(tokenize=porter, id TEXT, description TEXT, notindexed=id)";
final createFood =
    "CREATE TABLE Food (id TEXT PRIMARY KEY, description TEXT, food_group TEXT, food_group_image TEXT, "
    "protein REAL, total_sugars REAL, sucrose REAL, glucose REAL, fructose REAL, lactose REAL, maltose REAL, "
    "dietary_fiber REAL, favourite BIT)";
final createFoodGroup =
    "CREATE TABLE FoodGroup (id INTEGER PRIMARY KEY, name TEXT, image TEXT, enabled BIT)";

final createScripts = [createFoodSearch, createFood, createFoodGroup];

createTables(Database db, int version) async {
  createScripts.forEach((script) async => await db.execute(script));
}

populateTables(Database db, int version) async {
  await populateFoods(db, await rootBundle.loadString('json/foods.json'));
  await populateFoodGroups(db, await rootBundle.loadString('json/food_groups.json'));
}

populateFoods(final Database db, final String foodsJSON) async {
  List<Food> foods = List<Food>();

  for (final foodJSON in json.decode(foodsJSON)) {
    foods.add(Food.fromMap(foodJSON));
  }

  final batch = db.batch();

  for (var food in foods) {
    batch.rawInsert(
        "INSERT Into Food (id, description, food_group, food_group_image, favourite,"
        " protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietary_fiber)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
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

populateFoodGroups(Database db, final String foodGroupsJSON) async {
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
