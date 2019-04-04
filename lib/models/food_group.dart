import 'dart:convert';

FoodGroup foodGroupFromJson(String str) {
  final jsonData = json.decode(str);
  return FoodGroup.fromMap(jsonData);
}

String foodGroupToJson(FoodGroup data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class FoodGroup {
  int id;
  bool enabled;
  String name;
  String image;

  FoodGroup({this.id, this.enabled, this.name, this.image});

  factory FoodGroup.fromMap(Map<String, dynamic> json) => FoodGroup(
        id: json["id"],
        enabled: json["enabled"] == 1,
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() =>
      {"id": id, "enabled": enabled, "name": name, "image": image};
}

final List<FoodGroup> foodGroups = [
  FoodGroup(id: 1, enabled: true, name: "Beef Products", image: "images/group_109599.jpg"),
  FoodGroup(
      id: 2, enabled: true, name: "Baked Products", image: "images/group_156096.jpg"),
  FoodGroup(
      id: 3,
      enabled: true,
      name: "Vegetables and Vegetable Products",
      image: "images/group_298710.jpg"),
  FoodGroup(
      id: 4,
      enabled: true,
      name: "Soups, Sauces, and Gravies",
      image: "images/group_422025.jpg"),
  FoodGroup(
      id: 5,
      enabled: true,
      name: "Lamb, Veal, and Game Products",
      image: "images/group_365019.jpg"),
  FoodGroup(
      id: 6, enabled: true, name: "Poultry Products", image: "images/group_271121.jpg"),
  FoodGroup(
      id: 7,
      enabled: true,
      name: "Legumes and Legume Products",
      image: "images/group_128426.jpg"),
  FoodGroup(id: 8, enabled: true, name: "Beverages", image: "images/group_335257.jpg"),
  FoodGroup(id: 9, enabled: true, name: "Baby Foods", image: "images/group_267381.jpg"),
  FoodGroup(id: 10, enabled: true, name: "Fast Foods", image: "images/group_105699.jpg"),
  FoodGroup(
      id: 11,
      enabled: true,
      name: "Fruits and Fruit Juices",
      image: "images/group_296131.jpg"),
  FoodGroup(id: 12, enabled: true, name: "Sweets", image: "images/group_302505.jpg"),
  FoodGroup(
      id: 13, enabled: true, name: "Breakfast Cereals", image: "images/group_228657.jpg"),
  FoodGroup(
      id: 14, enabled: true, name: "Pork Products", image: "images/group_291658.jpg"),
  FoodGroup(
      id: 15,
      enabled: true,
      name: "Dairy and Egg Products",
      image: "images/group_394688.jpg"),
  FoodGroup(
      id: 16,
      enabled: true,
      name: "Finfish and Shellfish Products",
      image: "images/group_146792.jpg"),
  FoodGroup(
      id: 17, enabled: true, name: "Fats and Oils", image: "images/group_262616.jpg"),
  FoodGroup(
      id: 18,
      enabled: true,
      name: "Cereal Grains and Pasta",
      image: "images/group_44723.jpg"),
  FoodGroup(id: 19, enabled: true, name: "Snacks", image: "images/group_381292.jpg"),
  FoodGroup(
      id: 20,
      enabled: true,
      name: "Sausages and Luncheon Meats",
      image: "images/group_326864.jpg"),
  FoodGroup(
      id: 21,
      enabled: true,
      name: "American Indian/Alaska Native Foods",
      image: "images/group_329043.jpg"),
  FoodGroup(
      id: 22,
      enabled: true,
      name: "Nut and Seed Products",
      image: "images/group_195632.jpg"),
  FoodGroup(
      id: 23,
      enabled: true,
      name: "Meals, Entrees, and Side Dishes",
      image: "images/group_388602.jpg"),
  FoodGroup(
      id: 24, enabled: true, name: "Restaurant Foods", image: "images/group_254650.jpg"),
  FoodGroup(
      id: 25, enabled: true, name: "Spices and Herbs", image: "images/group_264152.jpg")
];