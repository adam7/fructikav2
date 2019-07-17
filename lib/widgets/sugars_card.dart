import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';

class SugarRow extends StatelessWidget {
  final Nutrient nutrient;

  SugarRow(this.nutrient);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Text(nutrient.name)),
      Text(nutrient.formattedValue)
    ]);
  }
}

class SugarsCard extends StatelessWidget {
  final Food food;

  SugarsCard(this.food);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      SugarRow(food.totalSugars),
      Divider(),
      SugarRow(food.fructose),
      Divider(),
      SugarRow(food.glucose),
      Divider(),
      SugarRow(food.sucrose),
      Divider(),
      SugarRow(food.maltose),
      Divider()
    ]));
  }
}
