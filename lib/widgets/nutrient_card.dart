import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fructika/models/nutrient.dart';

class NutrientCard extends StatelessWidget {
  final Nutrient nutrient;
  final Future<double> warningLevel;

  NutrientCard(this.nutrient, { Future<double> warningLevel } ): this.warningLevel = warningLevel ?? Future.value(-1.0);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Stack(children: <Widget>[
              _buildWarningIcon(),
              Align(
                  child: Text(nutrient.name,
                      style: Theme.of(context).textTheme.title),
                  alignment: Alignment.topCenter),
              Align(
                  child: Text(nutrient.formattedValue,
                      style: TextStyle(fontSize: 50)),
                  alignment: Alignment.center),
            ])));
  }

  _buildWarningIcon() {
    return FutureBuilder<double>(
        future: warningLevel,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data >= 0 && (nutrient.value ?? 0) > snapshot.data) {
            return Align(child: Icon(Icons.warning, color: Theme.of(context).accentColor,), alignment: Alignment.topRight);
          } else {
            return Align();
          }
        });
  }
}
