import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fructika/models/nutrient.dart';

class NutrientCard extends StatelessWidget {
  final Nutrient nutrient;

  NutrientCard(this.nutrient);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Stack(children: <Widget>[
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
}
