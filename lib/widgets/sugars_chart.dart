import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';

class SugarsChart extends StatelessWidget {
  final Food food;

  final _arcRendererConfig = ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [ArcLabelDecorator()]);

  SugarsChart(this.food);

  @override
  Widget build(BuildContext context) {
    return PieChart(_createSeriesList(food),
        defaultRenderer: _arcRendererConfig,
        );
  }

  List<Series<PieSegment, String>> _createSeriesList(Food food) {
    final data = [
      new PieSegment(food.fructose.toString(), food.fructose.value ?? 0),
      new PieSegment(food.glucose.toString(), food.glucose.value ?? 0),
      new PieSegment(food.sucrose.toString(), food.sucrose.value ?? 0),
      new PieSegment(food.glucose.toString(), food.maltose.value ?? 0)
    ];

    return [
      Series<PieSegment, String>(        
        displayName: "Total sugars ${food.totalSugars.value} g",
        id: 'Segments',
        domainFn: (PieSegment segment, _) => segment.segment,
        measureFn: (PieSegment segment, _) => segment.measure,
        data: data,
      )
    ];
  }
}

class PieSegment {
  final String segment;
  final double measure;

  PieSegment(this.segment, this.measure);
}
