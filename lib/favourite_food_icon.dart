import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'database/database_provider.dart';
import 'models/food.dart';

class FavouriteFoodIcon extends StatefulWidget {
  final Food food;
  final DatabaseProvider databaseProvider;

  const FavouriteFoodIcon(
      {Key key, @required this.food, @required this.databaseProvider})
      : super(key: key);

  @override
  _FavouriteFoodIconState createState() => _FavouriteFoodIconState();
}

class _FavouriteFoodIconState extends State<FavouriteFoodIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          widget.food.favourite ? Icons.favorite : Icons.favorite_border,
          color: widget.food.favourite ? Colors.red : null,
        ),
        onPressed: () {
          setState(() {
            widget.food.favourite = !widget.food.favourite;
          });
          widget.databaseProvider.updateFood(widget.food);
        });
  }
}
