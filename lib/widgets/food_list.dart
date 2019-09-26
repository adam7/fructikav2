import 'package:flutter/material.dart';
import 'package:fructika/widgets/favourite_food_icon.dart';
import 'package:fructika/food_route.dart';
import 'package:fructika/models/food.dart';

class FoodList extends StatefulWidget {
  final List<Food> foods;

  FoodList({Key key, @required this.foods});

  @override
  State<StatefulWidget> createState() => FoodListState();
}

class FoodListState extends State<FoodList> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: widget.foods.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return _buildFoodTile(widget.foods[index]);
        });
  }

  _buildFoodTile(Food food) {
    return ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FoodRoute(food)));
        },
        leading: Hero(
            tag: food.description,
            child: CircleAvatar(
                backgroundImage: Image.asset(food.imagePath).image)),
        title: Text(
          food.description,
          style: _biggerFont,
        ),
        trailing: FavouriteFoodIcon(food: food));
  }
}
