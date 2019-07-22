import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'nutrient.dart';

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
      : totalSugars = Nutrient("Total Sugars", totalSugarsValue),
        fructose = Nutrient("Fructose", fructoseValue, color: Color(0xff29b6f6)),
        sucrose = Nutrient("Sucrose", sucroseValue, color: Color(0xff5c6bc0)),
        glucose = Nutrient("Glucose", glucoseValue, color: Color(0xffffa726)),
        maltose = Nutrient("Maltose", maltoseValue,  color: Color(0xff8d6e63)),
        lactose = Nutrient("Lactose", lactoseValue),
        protein = Nutrient("Protein", proteinValue),
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
