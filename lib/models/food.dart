import 'dart:typed_data';

import 'package:flutter/material.dart';

class Nutrient {
  final String name;
  final num value;
  // final MaterialColor color;

  // Nutrient(this.name, this.value, this.color);
  Nutrient(this.name, this.value);
  
  String get formattedValue {
    final valueAsFixed = value?.toStringAsFixed(2) ??  '?';

    return "${valueAsFixed}g";
  }

  @override
  String toString() {
    return "$name $formattedValue";
  }
}

class Food {
  String id;
  String description;
  String foodGroupImage;
  String foodGroup;
  Uint8List matchinfo;
  bool favourite;

  final Nutrient protein;
  final Nutrient totalSugars;
  final Nutrient sucrose;
  final Nutrient glucose;
  final Nutrient fructose;
  final Nutrient lactose;
  final Nutrient maltose;
  final Nutrient dietaryFiber;

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
      num proteinValue,
      num totalSugarsValue,
      num sucroseValue,
      num glucoseValue,
      num fructoseValue,
      num lactoseValue,
      num maltoseValue,
      num dietaryFiberValue})
      : protein = Nutrient("Protein", proteinValue),
        totalSugars = Nutrient("Total Sugars", totalSugarsValue),
        sucrose = Nutrient("Sucrose", sucroseValue),
        glucose = Nutrient("Glucose", glucoseValue),
        fructose = Nutrient("Fructose", fructoseValue),
        lactose = Nutrient("Lactose", lactoseValue),
        maltose = Nutrient("Maltose", maltoseValue),
        dietaryFiber = Nutrient("Dietary Fiber", dietaryFiberValue);

  factory Food.fromMap(Map<String, dynamic> json) {
    return new Food(
        id: json["id"],
        description: json["description"],
        foodGroup: json["food_group"],
        foodGroupImage: json["food_group_image"],
        matchinfo: json["matchinfo"],
        proteinValue: json["protein"],
        totalSugarsValue: json["total_sugars"],
        sucroseValue: json["sucrose"],
        glucoseValue: json["glucose"],
        fructoseValue: json["fructose"],
        lactoseValue: json["lactose"],
        maltoseValue: json["maltose"],
        dietaryFiberValue: json["dietaryFiber"],
        favourite: json["favourite"] == 1);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "food_group": foodGroup,
        "food_group_image": foodGroupImage,
        "favourite": favourite ? 1 : 0,
        "protein": protein.value,
        "total_sugars": totalSugars.value,
        "sucrose": sucrose.value,
        "glucose": glucose.value,
        "fructose": fructose.value,
        "lactose": lactose.value,
        "maltose": maltose.value,
        "dietary_fiber": dietaryFiber.value
      };
}
