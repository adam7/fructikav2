import 'package:flutter/material.dart';
import 'package:fructika/database/sql_database_provider.dart';
import 'package:fructika/favourite_food_icon.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:fructika/widgets/glucose_fructose_gauge.dart';
import 'package:fructika/widgets/nutrient_card.dart';
import 'package:fructika/widgets/sugars_card.dart';
import 'package:fructika/widgets/sugars_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class HeroHeader implements SliverPersistentHeaderDelegate {
  final Food food;
  final VoidCallback onLayoutToggle;
  double maxExtent;
  double minExtent;

  HeroHeader({this.onLayoutToggle, this.minExtent, this.maxExtent, this.food});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: food.description,
              child: Image.asset(
                food.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                  stops: [0.5, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.repeated,
                ),
              ),
            ),
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              child: Text(
                food.description,
                style: TextStyle(fontSize: 32.0, color: Colors.white),
              ),
            )
          ],
        ));
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}

class FoodRoute extends StatelessWidget {
  final Food food;
  FoodRoute(this.food, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FructikaAppBar(
        title: Text(food.foodGroup),
      ),
      body: _scrollView(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColorLight,
          mini: true,
          child: FavouriteFoodIcon(
              food: food, databaseProvider: SqlDatabaseProvider.db)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget _scrollView(BuildContext context) {
    final preferencesHelper = Provider.of<PreferencesHelper>(context);

    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate:
                HeroHeader(minExtent: 100.0, maxExtent: 300.0, food: food),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildListDelegate(<Widget>[
              NutrientCard(food.fructose, warningLevel:  preferencesHelper.getWarningLevel()),
              GlucoseFructoseGauge(food),
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildListDelegate(<Widget>[
              SugarsChart(food),
              SugarsCard(food),
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildListDelegate(<Widget>[
              NutrientCard(food.lactose),
              NutrientCard(food.protein)
            ]),
          ),
        ],
      ),
    );
  }
}
