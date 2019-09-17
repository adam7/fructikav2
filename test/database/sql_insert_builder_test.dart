import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/database/sql_insert_builder.dart';
import 'utils.dart';

void main() {
  test("foodInsert", () {
    final expected = """
      INSERT Into Food (id, description, food_group, food_group_image, favourite,
        protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietary_fiber)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)""";

    final actual = SqlInsertBuilder.foodInsert;

    isSqlEqual(actual, expected);
  });

  test("foodSearchInsert", () {
    final expected = "INSERT Into FoodSearch (id,description) VALUES (?,?)";

    final actual = SqlInsertBuilder.foodSearchInsert;

    isSqlEqual(actual, expected);
  });
}
