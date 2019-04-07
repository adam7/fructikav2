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
