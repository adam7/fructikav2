import 'dart:convert';

Food foodFromJson(String str) {
  final jsonData = json.decode(str);
  return Food.fromMap(jsonData);
}

String foodToJson(Food data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Food {
  String id;
  String description;
  String foodGroupImage;
  String foodGroup;
  // double protein;
  // double totalSugars;
  // double sucrose;
  // double glucose;
  // double fructose;
  // double lactose;
  // double maltose;
  // double dietaryFiber;
  bool favourite;

  Food(
      {this.id,
      this.description,
      this.foodGroup,
      this.foodGroupImage,
      this.favourite});

  factory Food.fromMap(Map<String, dynamic> json) => new Food(
      id: json["id"],
      description: json["description"],
      foodGroup: json["food_group"],
      foodGroupImage: json["food_group_image"],
      favourite: json["favourite"] == 1);

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "food_group": foodGroup,
        "food_group_image": foodGroupImage,
        "favourite": favourite
      };
}

// data for testing
List<Food> foods = [
  Food(
      description: "Raouf",
      foodGroup: "Rahiche",
      foodGroupImage: "",
      favourite: false),
  Food(
      description: "Zaki",
      foodGroup: "oun",
      foodGroupImage: "",
      favourite: false),
  Food(
      description: "oussama",
      foodGroup: "ali",
      foodGroupImage: "",
      favourite: false),
];
