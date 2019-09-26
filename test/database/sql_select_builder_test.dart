import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/sql_select_builder.dart';
import 'utils.dart';

void main() {
  group("buildSearchQuery", () {
    test("when OS is iOS and includeUnknownFructose is true", () {
      final expected = """
          SELECT Food.id AS id, Food.description AS description, Food.food_group AS food_group, Food.food_group_image AS food_group_image, 
              favourite, protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietary_fiber
          FROM Food 
            JOIN (SELECT id, rank FROM FoodSearch WHERE FoodSearch MATCH ?) USING(id) 
            INNER JOIN FoodGroup ON Food.food_group = FoodGroup.name 
          WHERE FoodGroup.enabled = 1
          ORDER BY rank""";

      final actual = SqlSelectBuilder.buildSearchQuery(true, true);

      isSqlEqual(actual, expected);
    });

    test("when OS is iOS and includeUnknownFructose is false", () {
      final expected = """
        SELECT Food.id AS id, Food.description AS description, Food.food_group AS food_group, Food.food_group_image AS food_group_image, 
          favourite, protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietary_fiber
        FROM Food 
          JOIN (SELECT id, rank FROM FoodSearch WHERE FoodSearch MATCH ?) USING(id) 
          INNER JOIN FoodGroup ON Food.food_group = FoodGroup.name 
        WHERE FoodGroup.enabled = 1
          AND fructose IS NOT NULL 
        ORDER BY rank""";

      final actual = SqlSelectBuilder.buildSearchQuery(true, false);

      isSqlEqual(actual, expected);
    });

    test("when OS is Android and includeUnknownFructose is true", () {
      final expected = """
        SELECT Food.id AS id, Food.description AS description, Food.food_group AS food_group, Food.food_group_image AS food_group_image, 
          favourite, protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietary_fiber, matchinfo      
        FROM Food 
          JOIN (SELECT id, matchinfo(FoodSearch) as matchinfo FROM FoodSearch WHERE FoodSearch MATCH ?) USING(id) 
          INNER JOIN FoodGroup ON Food.food_group = FoodGroup.name 
        WHERE FoodGroup.enabled = 1""";

      final actual = SqlSelectBuilder.buildSearchQuery(false, true);

      isSqlEqual(actual, expected);
    });

    test("when OS is Android and includeUnknownFructose is false", () {
      final expected = """
        SELECT Food.id AS id, Food.description AS description, Food.food_group AS food_group, Food.food_group_image AS food_group_image, 
          favourite, protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietary_fiber, matchinfo      
        FROM Food 
          JOIN (SELECT id, matchinfo(FoodSearch) as matchinfo FROM FoodSearch WHERE FoodSearch MATCH ?) USING(id) 
          INNER JOIN FoodGroup ON Food.food_group = FoodGroup.name 
        WHERE FoodGroup.enabled = 1
          AND fructose IS NOT NULL""";

      final actual = SqlSelectBuilder.buildSearchQuery(false, false);

      isSqlEqual(actual, expected);
    });
  });

  test("foodCountQuery", () {
    final expected = "SELECT COUNT(*) FROM Food";

    final actual = SqlSelectBuilder.foodCountQuery;

    isSqlEqual(actual, expected);
  });
}
