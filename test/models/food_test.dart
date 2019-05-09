import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food.dart';

void main() {
  group("Food model", () {
      final jsonFood = Map<String, dynamic>.from({
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

      final modelFood = Food(
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
        dietaryFiber: 8.0
      );

    test("mapping to Food from json populates model", () {
      final food = Food.fromMap(jsonFood);

      expect(food.description, equals(jsonFood["description"]));
      expect(food.foodGroup, equals(jsonFood["food_group"]));
      expect(food.foodGroupImage, equals(jsonFood["food_group_image"]));
      expect(food.favourite, equals(true), reason: "SQLite stores bool as 1 or 0 so we should map 1 to true");
      expect(food.protein, equals(jsonFood["protein"]));
      expect(food.totalSugars, equals(jsonFood["total_sugars"]));
      expect(food.sucrose, equals(jsonFood["sucrose"]));
      expect(food.glucose, equals(jsonFood["glucose"]));
      expect(food.fructose, equals(jsonFood["fructose"]));
      expect(food.lactose, equals(jsonFood["lactose"]));
      expect(food.maltose, equals(jsonFood["maltose"]));
      expect(food.dietaryFiber, equals(jsonFood["dietaryFiber"]));
    });

    test("mapping to json from Food populates json", (){
      final json = modelFood.toMap();

      expect(json["description"], equals(modelFood.description));
      expect(json["food_group"], equals(modelFood.foodGroup));
      expect(json["food_group_image"], equals(modelFood.foodGroupImage));
      expect(json["favourite"], equals(1), reason: "SQLite stores bool as 1 or 0 so we should map true to 1");
      expect(json["protein"], equals(modelFood.protein));
      expect(json["total_sugars"], equals(modelFood.totalSugars));
      expect(json["sucrose"], equals(modelFood.sucrose));
      expect(json["glucose"], equals(modelFood.glucose));
      expect(json["fructose"], equals(modelFood.fructose));
      expect(json["lactose"], equals(modelFood.lactose));
      expect(json["maltose"], equals(modelFood.maltose));
      expect(json["dietary_fiber"], equals(modelFood.dietaryFiber));
    });

    test("imagePath constructs the right path", () {
      expect(modelFood.imagePath, equals("images/image_name.jpg"));
    });
  });
}
