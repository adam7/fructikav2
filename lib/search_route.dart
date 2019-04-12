import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/database.dart';
import 'package:fructika/food_list.dart';
import 'package:fructika/models/food.dart';

class SearchRoute extends StatefulWidget {
  final String title;

  SearchRoute({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  final TextEditingController _search = new TextEditingController();

  List<Food> foods = List<Food>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Search Foods")),
        body: Column(children: <Widget>[
          TextField(
              controller: _search,
              onSubmitted: (text) {
                if (text.isEmpty) {
                  setState(() {
                    foods = List<Food>();
                  });
                } else {
                  DBProvider.db.searchFoods(text).then((result) {
                    setState(() {
                      foods = result;
                    });
                  });
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search')),
          Expanded(child: FoodList(foods: foods))
        ]),
        drawer: AppDrawer());
  }
}
