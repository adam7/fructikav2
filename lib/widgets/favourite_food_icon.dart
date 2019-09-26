import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/database/repository.dart';
import 'package:provider/provider.dart';

class FavouriteFoodIcon extends StatefulWidget {
  final Food food;

  const FavouriteFoodIcon({Key key, @required this.food}) : super(key: key);

  @override
  _FavouriteFoodIconState createState() => _FavouriteFoodIconState();
}

class _FavouriteFoodIconState extends State<FavouriteFoodIcon> {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);

    return IconButton(
        icon: Icon(
          widget.food.favourite ? Icons.favorite : Icons.favorite_border,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {
          setState(() {
            widget.food.favourite = !widget.food.favourite;
          });
          repository.updateFood(widget.food);
        });
  }
}
