import 'dart:math';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/models/nutrient.dart';

class GlucoseFructoseGauge extends StatelessWidget {
  final Food food;

  final _arcRendererConfig = ArcRendererConfig(
      arcWidth: 30, startAngle: 4 / 5 * pi, arcLength: 7 / 5 * pi);

  GlucoseFructoseGauge(this.food);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                        "${food.fructose.name}/${food.glucose.name} Balance")),
                _buildPieChart()
              ],
            )));
  }

  _buildPieChart() {
    if (food?.glucose?.value != null && food?.fructose?.value != null) {
      return PieChart(_createSeriesList(food),
          defaultRenderer: _arcRendererConfig,
          behaviors: [
            // DatumLegend(position: BehaviorPosition.bottom, desiredMaxColumns: 1)
          ]);
    }else{
      return Container();
    }
  }

  List<Series<Nutrient, String>> _createSeriesList(Food food) {
    final nutrients = [food.fructose, food.glucose];

    return [
      new Series<Nutrient, String>(
        id: 'Segments',
        domainFn: (nutrient, _) => nutrient.name,
        measureFn: (nutrient, _) => nutrient.value,
        colorFn: (nutrient, _) => ColorUtil.fromDartColor(nutrient.color),
        data: nutrients,
      )
    ];
  }
}
