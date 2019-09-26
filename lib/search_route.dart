import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/utilities/shared_preferences_helper.dart';
import 'package:fructika/utilities/titles.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/widgets/food_list.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:provider/provider.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  final TextEditingController _search = new TextEditingController();
  List<Food> foods = List<Food>();

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    final preferencesHelper = Provider.of<PreferencesHelper>(context);

    return Scaffold(
        appBar: FructikaAppBar(
            title: TextField(
                controller: _search,
                onSubmitted: (text) {},
                onChanged: (text) async {
                  if (text.isEmpty || text.length < 3) {
                    setState(() {
                      foods = [];
                    });
                  } else {
                    var results =
                        await repository.searchFoods(text, preferencesHelper);

                    setState(() {
                      foods = results;
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
