import 'package:flutter/material.dart';
import 'package:fructika/database/sql_database_provider.dart';
import 'package:fructika/favourite_food_icon.dart';
import 'package:fructika/models/food.dart';

class FoodRoute extends StatelessWidget {
  final Food food;

  FoodRoute({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.description),
      ),
      body: Column(
        children: [
          Image.asset(
            food.imagePath,
            width: 600,
            fit: BoxFit.cover,
          ),
          _buildTitleSection(food),
          ListTile(
            trailing:
                CircleAvatar(child: Text(food.fructose?.toStringAsPrecision(1) ?? "?")),
            title: Text('Fructose'),
          ),
          ListTile(
            trailing:
                CircleAvatar(child: Text(food.maltose?.toStringAsPrecision(1) ?? "?")),
            title: Text('Maltose'),
          ),
        ],
      ),
    );
  }
}

Container _buildTitleSection(Food food) {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  food.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                food.foodGroup,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        FavouriteFoodIcon(food: food, databaseProvider: SqlDatabaseProvider.db)
      ],
    ),
  );
}
