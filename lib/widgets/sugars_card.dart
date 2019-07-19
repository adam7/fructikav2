import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';

class SugarRow extends StatelessWidget {
  final Nutrient nutrient;
  final Color color = Colors.cyan;

  SugarRow(this.nutrient);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.pie_chart, color: color, size: 15),
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
    final textTheme = Theme.of(context).textTheme;

    return Card(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(children: [
              Row(children: [
                Expanded(
                    child:
                        Text(food.totalSugars.name, style: textTheme.subhead)),
                Text(food.totalSugars.formattedValue, style: textTheme.subhead)
              ]),
              Divider(),
              SugarRow(food.fructose),
              Divider(),
              SugarRow(food.glucose),
              Divider(),
              SugarRow(food.sucrose),
              Divider(),
              SugarRow(food.maltose),
              Divider()
            ])));
  }
}
