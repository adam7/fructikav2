import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:fructika/database/sql_database_provider.dart';
import 'package:fructika/food_list.dart';
import 'package:fructika/models/food.dart';

class FavouritesRoute extends StatelessWidget {
  final favouriteFoods = SqlDatabaseProvider.db.getFavouriteFoods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FructikaAppBar(title: Text(Titles.favouriteTitle)),
        body: FutureBuilder<List<Food>>(
          future: favouriteFoods,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return FoodList(foods: snapshot.data);
            else
              return Center(child: new CircularProgressIndicator());
          },
        ),
        drawer: AppDrawer());
  }
}
