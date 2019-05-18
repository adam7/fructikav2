import 'dart:math';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';

class GlucoseFructoseGauge extends StatelessWidget {
  final Food food;

  final _arcRendererConfig = ArcRendererConfig(
      arcWidth: 30, startAngle: 4 / 5 * pi, arcLength: 7 / 5 * pi);

  GlucoseFructoseGauge(this.food);

  @override
  Widget build(BuildContext context) {
    return PieChart(_createSeriesList(food),
        defaultRenderer: _arcRendererConfig,
        behaviors: [
          DatumLegend(position: BehaviorPosition.bottom, desiredMaxColumns: 1)
        ]);
  }

  List<Series<GaugeSegment, String>> _createSeriesList(Food food) {
    final data = [
      new GaugeSegment("Fructose ${food.fructose}g", food.fructose ?? 0),
      new GaugeSegment('Glucose ${food.glucose}g', food.glucose ?? 0)
    ];

    return [
      new Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.measure,
        data: data,
      )
    ];
  }
}

class GaugeSegment {
  final String segment;
  final double measure;

  GaugeSegment(this.segment, this.measure);
}
