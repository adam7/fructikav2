import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'database/sql_database_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fructika/models/food_group.dart';

class FoodGroupRoute extends StatelessWidget {
  final foodgroups = SqlDatabaseProvider.db.getAllFoodGroups();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Food Groups")),
        body: FutureBuilder<List<FoodGroup>>(
          future: foodgroups,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return _buildFoodGroupCards(snapshot.data);
            else
              return Center(child: new CircularProgressIndicator());
          },
        ),
        drawer: AppDrawer());
  }

  Swiper _buildFoodGroupCards(List<FoodGroup> foodGroups) {
    List<Widget> foodGroupCards = List<Widget>();

    for (var foodGroup in foodGroups) {
      foodGroupCards.add(FoodGroupCard(foodGroup: foodGroup));
    }

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return FoodGroupCard(foodGroup: foodGroups[index]);
      },
      itemCount: foodGroups.length,
      // viewportFraction: 0.9,
      // scale: 0.9,
      // pagination: SwiperPagination.dots,
      // layout: SwiperLayout.DEFAULT,
      pagination: SwiperPagination.fraction
    );
  }
}

class FoodGroupCard extends StatefulWidget {
  final FoodGroup foodGroup;

  FoodGroupCard({Key key, @required this.foodGroup}) : super(key: key);

  @override
  _FoodGroupCardState createState() => _FoodGroupCardState();
}

class _FoodGroupCardState extends State<FoodGroupCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: EdgeInsets.all(12.0),
      clipBehavior: Clip.antiAlias,
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
                setState(() {
                  widget.foodGroup.enabled = value;
                });
                SqlDatabaseProvider.db.updateFoodGroup(widget.foodGroup);
              })
        ],
      ),
    );
  }
}
