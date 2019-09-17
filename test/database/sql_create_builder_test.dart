import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/sql_create_builder.dart';
import 'utils.dart';

void main() {
  test("buildCreateFoodSearch when OS is iOS", () {
    final expected =
        "CREATE VIRTUAL TABLE FoodSearch using fts5(id UNINDEXED, description)";

    final actual = SqlCreateBuilder.buildCreateFoodSearch(true);

    isSqlEqual(actual, expected);
  });

  test("buildCreateFoodSearch when OS is Android", () {
    final expected =
        "CREATE VIRTUAL TABLE FoodSearch using fts4(tokenize=porter, id TEXT, description TEXT, notindexed=id)";

    final actual = SqlCreateBuilder.buildCreateFoodSearch(false);

    isSqlEqual(actual, expected);
  });

  test("createFood", () {
    final expected = """
      CREATE TABLE Food (id TEXT PRIMARY KEY, description TEXT, food_group TEXT, food_group_image TEXT, 
        protein REAL, total_sugars REAL, sucrose REAL, glucose REAL, fructose REAL, lactose REAL, 
        maltose REAL, dietary_fiber REAL, favourite BIT)""";

    final actual = SqlCreateBuilder.createFood;

    isSqlEqual(actual, expected);
  });

  test("createFoodGroup", () {
    final expected =
        "CREATE TABLE FoodGroup (id INTEGER PRIMARY KEY, name TEXT, image TEXT, enabled BIT)";

    final actual = SqlCreateBuilder.createFoodGroup;

    isSqlEqual(actual, expected);
  });
}
