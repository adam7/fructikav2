import 'package:flutter/material.dart';
import 'package:fructika/models/food.dart';

class FructoseCard extends StatelessWidget {
  final Food food;
  FructoseCard(this.food);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Align(
            alignment: Alignment.center,
            child: Text("${food.fructose.formattedValue}",
                style: TextStyle(fontSize: 50))));
  }
}
