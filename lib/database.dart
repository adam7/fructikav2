import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/models/food_group.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FoodsDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await createFoodTable(db);
      await createFoodGroupTable(db);
      await populateFoodGroupTable(db);
      await populateFoodTable(db);
    });
  }

  createFoodTable(Database db) async {
    await db.execute("CREATE VIRTUAL TABLE Food using fts4("
        "description TEXT,"
        "food_group TEXT,"
        "food_group_image TEXT,"
        "favourite BIT,"
        "notindexed=food_group,"
        "notindexed=food_group_image,"
        "notindexed=favourite"
        ")");
  }

  createFoodGroupTable(Database db) async {
    await db.execute("CREATE TABLE FoodGroup ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "image TEXT,"
        "enabled BIT"
        ")");
  }

  populateFoodTable(Database db) async {
    final batch = db.batch();

    for (var food in foods) {
      batch.rawInsert(
          "INSERT Into Food (description,food_group,food_group_image,favourite)"
          " VALUES (?,?,?,?)",
          [
            food.description,
            food.foodGroup,
            food.foodGroupImage,
            food.favourite
          ]);
    }

    await batch.commit(noResult: true);
  }

  populateFoodGroupTable(Database db) async {
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
        "enabled": foodGroup.enabled ? 1 : 0
      });
    }

    await batch.commit(noResult: true);
  }

  newFoodGroup(FoodGroup foodGroup) async {
    final db = await database;

    return await db.rawInsert(
        "INSERT Into FoodGroup (id,name,image,enabled)"
        " VALUES (?,?,?,?)",
        [foodGroup.id, foodGroup.name, foodGroup.image, foodGroup.enabled]);
  }

  newFood(Food food) async {
    final db = await database;

    return await db.rawInsert(
        "INSERT Into Food (description,food_group,food_group_image,favourite)"
        " VALUES (?,?,?,?)",
        [
          food.description,
          food.foodGroup,
          food.foodGroupImage,
          food.favourite
        ]);
  }

  toggleFavourite(Food food) async {
    final db = await database;

    Food toggled = Food(
        description: food.description,
        foodGroup: food.foodGroup,
        foodGroupImage: food.foodGroupImage,
        favourite: !food.favourite);

    var result = await db.update("Food", toggled.toMap(),
        where: "description = ?", whereArgs: [food.description]);

    return result;
  }

  updateFood(Food food) async {
    final db = await database;
    var res = await db.update("Food", food.toMap(),
        where: "description = ?", whereArgs: [food.description]);
    return res;
  }

  getFood(String description) async {
    final db = await database;
    var result = await db
        .query("Food", where: "description = ?", whereArgs: [description]);
    return result.isNotEmpty ? Food.fromMap(result.first) : null;
  }

  Future<List<Food>> getFavouriteFoods() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Food WHERE blocked=1");
    var result =
        await db.query("Food", where: "favourite = ? ", whereArgs: [1]);

    List<Food> list =
        result.isNotEmpty ? result.map((c) => Food.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Food>> searchFoods(String searchText) async {
    final db = await database;

    var result =
        await db.query("Food", where: "description MATCH ? ", whereArgs: [1]);

    List<Food> list =
        result.isNotEmpty ? result.map((c) => Food.fromMap(c)).toList() : [];

    return list;
  }

  Future<List<Food>> getAllFoods() async {
    final db = await database;
    var result = await db.query("Food");
    List<Food> list =
        result.isNotEmpty ? result.map((c) => Food.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<FoodGroup>> getAllFoodGroups() async {
    final db = await database;
    var result = await db.query("FoodGroup");
    List<FoodGroup> list = result.isNotEmpty
        ? result.map((c) => FoodGroup.fromMap(c)).toList()
        : [];
    return list;
  }

  deleteFood(int id) async {
    final db = await database;
    return db.delete("Food", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Food");
  }
}
