import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/database.dart';
import 'package:fructika/food_route.dart';
import 'package:fructika/models/food.dart';

class SearchRoute extends StatefulWidget {
  final String title;

  SearchRoute({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final TextEditingController _search = new TextEditingController();

  List<Food> foods = List<Food>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Search Foods")),
        body: Column(
          children: <Widget>[
            TextField(
              controller: _search,
              onSubmitted: (text) {
                if (text.isEmpty) {
                  foods = List<Food>();
                  setState(() {});
                } else {
                  DBProvider.db.searchFoods(text).then((result) {
                    foods = result;
                    setState(() {});
                  });
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search)),
            ),
            Expanded(
                child: ListView.separated(
                    itemCount: foods.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildFoodTile(foods[index]);
                    }))
          ],
        ),
        drawer: AppDrawer());
  }

  _buildFoodTile(Food food) {
    return ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FoodRoute(food: food)));
        },
        leading: CircleAvatar(
            backgroundImage: Image.asset(food.foodGroupImage).image),
        title: Text(
          food.description,
          style: _biggerFont,
        ),
        trailing: IconButton(
          icon: Icon(
            // Add the lines from here...
            food.favourite ? Icons.favorite : Icons.favorite_border,
            color: food.favourite ? Colors.red : null,
          ),
          onPressed: () {
            setState(() {
              DBProvider.db.toggleFavourite(food);
            });
          },
        ));
  }
}
