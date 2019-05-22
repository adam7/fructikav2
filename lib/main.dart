import 'package:flutter/material.dart';
import 'package:fructika/search_route.dart';
import 'models/food.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Food food = Food(fructose: 1.0, glucose: 1.0, sucrose: 1.0, maltose: 1.0, description: "food", foodGroup: "Food group", foodGroupImage: "group_44723", favourite:false);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color.fromRGBO(105, 240, 175, 1),
            primaryColorLight: Color.fromRGBO(159, 255, 224, 1),
            primaryColorDark: Color.fromRGBO(43, 188, 126, 1),
            accentColor: Color.fromRGBO(240,105,170, 1)),
        title: 'Fructika',
        home: SearchRoute());
  }
}
