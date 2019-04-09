import 'package:flutter/material.dart';
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
            food.foodGroupImage,
            width: 600,
            fit: BoxFit.cover,
          ),
          _buildTitleSection(food),
        ],
      ),
    );
  }
}

Container _buildTitleSection(Food food)  {
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
                food.description,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.favorite,
          color: Colors.red[500],
        ),
      ],
    ),
  );
}
