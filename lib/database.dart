import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/models/food_group.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_rank/sqlite_rank.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FoodDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await createFoodTable(db);
      await createFoodSearchTable(db);
      await createFoodGroupTable(db);
      await populateFoodGroupTable(db);
      await populateFoods(db);
    });
  }

  createFoodSearchTable(Database db) async {
    await db.execute("CREATE VIRTUAL TABLE FoodSearch using fts4("
        "id TEXT,"
        "description TEXT,"
        "notindexed=id"
        ")");
  }

  createFoodTable(Database db) async {
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

  createFoodGroupTable(Database db) async {
    await db.execute("CREATE TABLE FoodGroup ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "image TEXT,"
        "enabled BIT"
        ")");
  }

  populateFoods(Database db) async {
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

    var result = await db.query("Food", where: "favourite = 1");

    return result.isNotEmpty ? result.map((f) => Food.fromMap(f)).toList() : [];
  }

  Future<List<Food>> searchFoods(String searchText) async {
    final db = await database;

    var searchQuery =
        "SELECT id, Food.description, Food.food_group, Food.food_group_image, matchinfo, Food.favourite"
        " FROM Food JOIN (SELECT id, matchinfo(FoodSearch) as matchinfo FROM FoodSearch WHERE FoodSearch MATCH ?)"
        " USING(id)";

    // var rows = await db.rawQuery("SELECT id,description,food_group,food_group_image,favourite,matchinfo(Food) as matchinfo FROM Food WHERE Food MATCH ?", ["$searchText*"]);
    var rows = await db.rawQuery(searchQuery, ["$searchText*"]);

    return rows.isNotEmpty ? _mapAndSortFoods(rows) : [];
  }

  Future<List<Food>> _mapAndSortFoods(List<Map<String, dynamic>> rows) async {
    var foods = rows.map((c) => Food.fromMap(c)).toList();

    foods.sort((f1, f2) => rank(f1.matchinfo).compareTo(rank(f2.matchinfo)));

    return foods;
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

// INSERT Into Food (id,description,food_group,food_group_image,favourite) VALUES ('one','banana','','',0);
// INSERT Into Food (id,description,food_group,food_group_image,favourite) VALUES ('two','apple','','',0);

// INSERT Into FoodSearch (id,description) VALUES ('one','banana');
// INSERT Into FoodSearch (id,description) VALUES ('two','apple');

// SELECT id, description, matchinfo(FoodSearch) as matchinfo FROM FoodSearch WHERE FoodSearch MATCH 'banana'
