import 'package:flutter/material.dart';
import 'package:fructika/database/sql_database_provider.dart';
import 'package:fructika/favourite_food_icon.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/glucose_fructose_gauge.dart';


class FoodRoute extends StatelessWidget {
  final Food food;

  FoodRoute({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.description),
      ),
      body: ListView(
        children: [
          Hero(
            tag: food.description,
            child: Image.asset(
              food.imagePath,
              width: 600,
              fit: BoxFit.cover,
            ),
          ),
          _buildTitleSection(food),
          GlucoseFructoseGauge(food, 300, 300),
          _buildNutrientListTile("Fructose", food.fructose),
          _buildNutrientListTile("Glucose", food.glucose),
          _buildNutrientListTile("Maltose", food.maltose),
          _buildNutrientListTile("Sucrose", food.sucrose),
          _buildNutrientListTile("Total Sugars", food.totalSugars),
          _buildNutrientListTile("Lactose", food.lactose),
          _buildNutrientListTile("Protein", food.protein),
        ],
      ),
    );
  }
}


ListTile _buildNutrientListTile(String title, num value) {
  return ListTile(
    trailing: Text("${value?.toStringAsFixed(1) ?? "?"} g" ),
    title: Text(title),
  );
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
