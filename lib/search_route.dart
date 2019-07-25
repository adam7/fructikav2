import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/database/database_provider.dart';
import 'package:fructika/food_list.dart';
import 'package:fructika/models/food.dart';

import 'widgets/fructika_app_bar.dart';

class SearchRoute extends StatefulWidget {
  final DatabaseProvider databaseProvider;
  final PreferencesHelper preferencesHelper;
  
  SearchRoute(this.databaseProvider, this.preferencesHelper, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  final TextEditingController _search = new TextEditingController();
  List<Food> foods = List<Food>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FructikaAppBar(
            title: TextField(
                controller: _search,
                onSubmitted: (text) {},
                onChanged: (text) {
                  if (text.isEmpty || text.length < 3) {
                    setState(() {
                      foods = [];
                    });
                  } else {
                    widget.databaseProvider.searchFoods(text, this.widget.preferencesHelper).then((result) {
                      setState(() {
                        foods = result;
                      });
                    });
                  }
                },
                textInputAction: TextInputAction.search,
                autofocus: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: Titles.foodSearchTitle))),
        body: FoodList(foods: foods),
        drawer: AppDrawer());
  }
}
