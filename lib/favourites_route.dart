import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/utilities/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:fructika/widgets/food_list.dart';
import 'package:fructika/models/food.dart';
import 'package:provider/provider.dart';

class FavouritesRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    final favouriteFoods = repository.getFavouriteFoods();

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
