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
      {"id": id, "enabled": enabled ? 1 : 0, "name": name, "image": image};
}
