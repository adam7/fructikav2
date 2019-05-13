import 'package:flutter/material.dart';
import 'package:fructika/search_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
