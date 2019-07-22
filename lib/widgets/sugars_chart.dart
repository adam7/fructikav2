import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/models/nutrient.dart';

class SugarsChart extends StatelessWidget {
  final Food food;

  SugarsChart(this.food);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: PieChart(
      _createSeriesList(food),
      defaultRenderer: ArcRendererConfig(arcWidth: 60),
    ));
  }

  List<Series<Nutrient, String>> _createSeriesList(Food food) {
    final nutrients = [
      food.fructose,
      food.glucose,
      food.sucrose,
      food.maltose
    ];

    return [
      Series<Nutrient, String>(
        displayName: "Total sugars ${food.totalSugars.value} g",
        id: 'NutrientSegments',
        domainFn: (nutrient, _) => nutrient.toString(),
        measureFn: (nutrient, _) => nutrient.value, //nutrient.value ?? 0,
        colorFn: (nutrient, _) => ColorUtil.fromDartColor(nutrient.color),
        data: nutrients,
      )
    ];
  }
}