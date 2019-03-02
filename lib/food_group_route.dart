import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:fructika/models/food_group.dart';

var foodgroups = <FoodGroup>[
  FoodGroup(true, "Pasta", "images/group_44723.jpg", "images/group_44723.jpg"),
  FoodGroup(
      true, "Pizza", "images/group_105699.jpg", "images/group_105699.jpg"),
  FoodGroup(
      true, "Bla bal", "images/group_109599.jpg", "images/group_109599.jpg"),
  FoodGroup(
      true, "sd", "images/group_128426.jpg", "images/group_128426.jpg"),
  FoodGroup(
      true, "fsdfs", "images/group_146792.jpg", "images/group_146792.jpg"),
  FoodGroup(
      true, "sdfaa", "images/group_156096.jpg", "images/group_156096.jpg"),
];

class FoodGroupRoute extends StatelessWidget {
  final String title;

  FoodGroupRoute({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return FoodGroupCard(foodGroup: foodgroups[index]);
          },
          itemCount: foodgroups.length,
          viewportFraction: 0.9,
          scale: 0.9,
          pagination: SwiperPagination(),
        ),
        drawer: AppDrawer());
  }
}

class FoodGroupCard extends StatefulWidget {
  FoodGroup foodGroup;

  FoodGroupCard({Key key, @required this.foodGroup}) :super(key:key);

  @override
  _FoodGroupCardState createState() => _FoodGroupCardState();
}

class _FoodGroupCardState extends State<FoodGroupCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(
            widget.foodGroup.image,
            width: 600,
            fit: BoxFit.scaleDown,
          ),
          SwitchListTile(
              title: Text(widget.foodGroup.name),
              subtitle: const Text('Enabled'),
              value: widget.foodGroup.enabled,
              onChanged: (bool value) {
                widget.foodGroup.enabled = value;
              })
        ],
      ),
    );
  }
}
