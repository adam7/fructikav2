import 'dart:math';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';

class GlucoseFructoseGauge extends StatelessWidget {
  final Food food;
  final bool animate;
  final double width;
  final double height;

  final _arcRendererConfig = ArcRendererConfig(
      arcWidth: 20, startAngle: 4 / 5 * pi, arcLength: 7 / 5 * pi);

  GlucoseFructoseGauge(this.food, this.width, this.height, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PieChart(_createSeriesList(food),
            defaultRenderer: _arcRendererConfig,
            behaviors: [DatumLegend(position: BehaviorPosition.bottom)]),
        width: width,
        height: height);
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
