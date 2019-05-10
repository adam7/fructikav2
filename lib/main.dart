import 'package:flutter/material.dart';
import 'package:fructika/search_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Fructika', home: SearchRoute());
  }
}
