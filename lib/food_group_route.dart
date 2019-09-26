import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fructika/models/food_group.dart';
import 'package:provider/provider.dart';

class FoodGroupRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
final repository = Provider.of<Repository>(context);

    return Scaffold(
        appBar: FructikaAppBar(title: Text("Food Groups")),
        body: FutureBuilder<List<FoodGroup>>(
          future: repository.getAllFoodGroups(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return _buildFoodGroupCards(snapshot.data);
            else
              return Center(child: CircularProgressIndicator());
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
final repository = Provider.of<Repository>(context);

    return Card(
        elevation: 12,
        margin: EdgeInsets.all(12.0),
        clipBehavior: Clip.antiAlias,
          child: Wrap(
            children: <Widget>[
              Image.asset(
                widget.foodGroup.image,
                fit: BoxFit.scaleDown,
              ),
              SwitchListTile(
                  title: Text(widget.foodGroup.name),
                  subtitle: widget.foodGroup.enabled
                      ? Text('Enabled')
                      : Text('Disabled'),
                  value: widget.foodGroup.enabled,
                  onChanged: (bool value) {
                    setState(() {
                      widget.foodGroup.enabled = value;
                    });
                    repository.updateFoodGroup(widget.foodGroup);
                  })
            ],
          ),
        );
  }
}
