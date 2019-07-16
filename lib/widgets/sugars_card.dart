import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';

class SugarsCard extends StatelessWidget {
  final Food food;
  
  SugarsCard(this.food);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      Row(children: [
        Expanded(child: Text(food.totalSugars.name)),
        Text(food.totalSugars.formattedValue)
      ]),
      Divider(),
      Row(children: [
        Expanded(child: Text(food.fructose.name)),
        Text(food.fructose.formattedValue)
      ]),
      Divider(),
      Row(children: [
        Expanded(child: Text(food.glucose.name)),
        Text(food.glucose.formattedValue)
      ]),
      Divider(),
      Row(children: [
        Expanded(child: Text(food.sucrose.name)),
        Text(food.sucrose.formattedValue)
      ]),
      Divider(),
      Row(children: [
        Expanded(child: Text(food.maltose.name)),
        Text(food.maltose.formattedValue)
      ])
    ]));
  }
}
