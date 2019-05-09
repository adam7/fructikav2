import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/food_group.dart';

void main() {
  group("Food Group model", () {
    test("mapping to Food from json populates model", () {
      final json = Map<String, dynamic>.from(
          {"id": 1, "enabled": 1, "name": "Food group", "image": "image_name"});

      final foodGroup = FoodGroup.fromMap(json);

      expect(foodGroup.id, equals(json["id"]));
      expect(foodGroup.name, equals(json["name"]));
      expect(foodGroup.image, equals(json["image"]));
      expect(foodGroup.enabled, equals(true),
          reason: "SQLite stores bool as 1 or 0 so we should map 1 to true");
    });

    test("mapping to json from Food populates json", () {
      final foodGroup = FoodGroup(
          id: 1, name: "Food group", image: "image_name", enabled: true);

      final json = foodGroup.toMap();

      expect(json["id"], equals(foodGroup.id));
      expect(json["name"], equals(foodGroup.name));
      expect(json["image"], equals(foodGroup.image));
      expect(json["enabled"], equals(1),
          reason: "SQLite stores bool as 1 or 0 so we should map true to 1");
    });
  });
}
