import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/database.dart';
import 'package:fructika/food_list.dart';
import 'package:fructika/models/food.dart';

class FavouritesRoute extends StatelessWidget {
  final String title;
  final favouriteFoods = DBProvider.db.getFavouriteFoods();

  FavouritesRoute({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
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
