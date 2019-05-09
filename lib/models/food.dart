import 'dart:typed_data';

class Food {
  String id;
  String description;
  String foodGroupImage;
  String foodGroup;
  Uint8List matchinfo;
  num protein;
  num totalSugars;
  num sucrose;
  num glucose;
  num fructose;
  num lactose;
  num maltose;
  num dietaryFiber;
  bool favourite;

  String get imagePath {
    return "images/$foodGroupImage.jpg";
  }

  Food(
      {this.id,
      this.description,
      this.foodGroup,
      this.foodGroupImage,
      this.matchinfo,
      this.favourite,
      this.protein,
      this.totalSugars,
      this.sucrose,
      this.glucose,
      this.fructose,
      this.lactose,
      this.maltose,
      this.dietaryFiber});

  factory Food.fromMap(Map<String, dynamic> json) {
    return new Food(
        id: json["id"],
        description: json["description"],
        foodGroup: json["food_group"],
        foodGroupImage: json["food_group_image"],
        matchinfo: json["matchinfo"],
        protein: json["protein"],
        totalSugars: json["total_sugars"],
        sucrose: json["sucrose"],
        glucose: json["glucose"],
        fructose: json["fructose"],
        lactose: json["lactose"],
        maltose: json["maltose"],
        dietaryFiber: json["dietaryFiber"],
        favourite: json["favourite"] == 1);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "food_group": foodGroup,
        "food_group_image": foodGroupImage,
        "favourite": favourite ? 1 : 0,
        "protein": protein,
        "total_sugars": totalSugars,
        "sucrose": sucrose,
        "glucose": glucose,
        "fructose": fructose,
        "lactose": lactose,
        "maltose": maltose,
        "dietary_fiber": dietaryFiber
      };
}
