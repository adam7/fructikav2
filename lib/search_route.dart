import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/database/database_provider.dart';
import 'package:fructika/food_list.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:provider/provider.dart';

class SearchRoute extends StatefulWidget {
  final DatabaseProvider databaseProvider;
  
  SearchRoute(this.databaseProvider, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  final TextEditingController _search = new TextEditingController();
  List<Food> foods = List<Food>();

  @override
  Widget build(BuildContext context) {
    final preferencesHelper = Provider.of<PreferencesHelper>(context);
    
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
                    widget.databaseProvider.searchFoods(text, preferencesHelper).then((result) {
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