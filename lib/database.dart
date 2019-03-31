import 'dart:async';
import 'dart:io';

import 'package:fructika/models/food.dart';
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
    String path = join(documentsDirectory.path, "FoodDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Food ("
          "id INTEGER PRIMARY KEY,"
          "description TEXT,"
          "food_group TEXT,"
          "food_group_image TEXT,"
          "favourite BIT"
          ")");
    });
  }

  newFood(Food food) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Food");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Food (id,description,food_group,food_group_image,favourite)"
        " VALUES (?,?,?,?,?)",
        [id, food.description, food.foodGroup, food.foodGroupImage, food.favourite]);
    return raw;
  }

  toggleFavourite(Food client) async {
    final db = await database;
    Food blocked = Food(
        id: client.id,
        description: client.description,
        foodGroup: client.foodGroup,
        foodGroupImage: client.foodGroupImage,
        favourite: !client.favourite);
    var res = await db.update("Food", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateFood(Food food) async {
    final db = await database;
    var res = await db.update("Food", food.toMap(),
        where: "id = ?", whereArgs: [food.id]);
    return res;
  }

  getFood(int id) async {
    final db = await database;
    var result = await db.query("Food", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? Food.fromMap(result.first) : null;
  }

  Future<List<Food>> getFavouriteFoods() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Food WHERE blocked=1");
    var result = await db.query("Food", where: "favourite = ? ", whereArgs: [1]);

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

  deleteFood(int id) async {
    final db = await database;
    return db.delete("Food", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Food");
  }
}
