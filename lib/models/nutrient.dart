import 'package:flutter/material.dart';

class Nutrient {
  final String name;
  final num value;
  final Color color;

  Nutrient(this.name, this.value, {this.color = Colors.black});

  String get formattedValue {
    final valueAsFixed = value?.toStringAsFixed(2) ?? '?';

    return "${valueAsFixed}g";
  }

  @override
  String toString() {
    return "$name $formattedValue";
  }
}
