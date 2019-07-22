import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fructika/models/nutrient.dart';

void main() {
  final name = "Nutrient name";
  final value = 5;
  final defaultColor = Colors.black;
  final pink = Colors.pink;

  group("Nutrient model", () {
    test("with name, value and color", () {
      final nutrient = Nutrient(name, value, color: pink);

      expect(nutrient.formattedValue, "$value.00g");
      expect(nutrient.name, name);
      expect(nutrient.toString(), "$name ${nutrient.formattedValue}");
      expect(nutrient.color, pink);
    });

    test("with name and value but no color", () {
      final nutrient = Nutrient(name, value);

      expect(nutrient.formattedValue, "$value.00g");
      expect(nutrient.name, name);
      expect(nutrient.toString(), "$name ${nutrient.formattedValue}");
      expect(nutrient.color, defaultColor);
    });

    test("with name, no value and no color", () {
      final nutrient = Nutrient(name, null);

      expect(nutrient.formattedValue, "?g");
      expect(nutrient.name, name);
      expect(nutrient.toString(), "$name ${nutrient.formattedValue}");
      expect(nutrient.color, defaultColor);
    });
  });
}
