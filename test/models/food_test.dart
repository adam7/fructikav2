import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';

void main() {
  group("Food model", () {
      final foodModel = Food(
          id: "id",
          description: "description",
          foodGroup: "food group name",
          foodGroupImage: "image_name",
          favourite: true,
          protein: 1.0,
          totalSugars: 2.0,
          sucrose: 3.0,
          glucose: 4.0,
          fructose: 5.0,
          lactose: 6.0,
          maltose: 7.0,
          dietaryFiber: 8.0);

    test("mapping to Food from json populates model", () {
      final json = Map<String, dynamic>.from({
        "id": "id",
        "description": "description",
        "food_group": "food group name",
        "food_group_image": "image_name",
        "favourite": 1,
        "protein": 1.0,
        "total_sugars": 2.0,
        "sucrose": 3.0,
        "glucose": 4.0,
        "fructose": 5.0,
        "lactose": 6.0,
        "maltose": 7.0,
        "dietaryFiber": 8.0
      });

      final food = Food.fromMap(json);

      expect(food.description, equals(json["description"]));
      expect(food.foodGroup, equals(json["food_group"]));
      expect(food.foodGroupImage, equals(json["food_group_image"]));
      expect(food.favourite, equals(true),
          reason: "SQLite stores bool as 1 or 0 so we should map 1 to true");
      expect(food.protein, equals(json["protein"]));
      expect(food.totalSugars, equals(json["total_sugars"]));
      expect(food.sucrose, equals(json["sucrose"]));
      expect(food.glucose, equals(json["glucose"]));
      expect(food.fructose, equals(json["fructose"]));
      expect(food.lactose, equals(json["lactose"]));
      expect(food.maltose, equals(json["maltose"]));
      expect(food.dietaryFiber, equals(json["dietaryFiber"]));
    });

    test("mapping to json from Food populates json", () {


      final json = foodModel.toMap();

      expect(json["description"], equals(foodModel.description));
      expect(json["food_group"], equals(foodModel.foodGroup));
      expect(json["food_group_image"], equals(foodModel.foodGroupImage));
      expect(json["favourite"], equals(1),
          reason: "SQLite stores bool as 1 or 0 so we should map true to 1");
      expect(json["protein"], equals(foodModel.protein));
      expect(json["total_sugars"], equals(foodModel.totalSugars));
      expect(json["sucrose"], equals(foodModel.sucrose));
      expect(json["glucose"], equals(foodModel.glucose));
      expect(json["fructose"], equals(foodModel.fructose));
      expect(json["lactose"], equals(foodModel.lactose));
      expect(json["maltose"], equals(foodModel.maltose));
      expect(json["dietary_fiber"], equals(foodModel.dietaryFiber));
    });

    test("imagePath constructs the right path", () {
      expect(foodModel.imagePath, equals("images/image_name.jpg"));
    });
  });
}
