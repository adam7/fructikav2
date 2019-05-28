import 'package:flutter/material.dart';
import 'package:fructika/database/sql_database_provider.dart';
import 'package:fructika/favourite_food_icon.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/glucose_fructose_gauge.dart';
import 'package:fructika/widgets/sugars_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';

class HeroHeader implements SliverPersistentHeaderDelegate {
  final Food food;
  final VoidCallback onLayoutToggle;
  double maxExtent;
  double minExtent;

  HeroHeader({this.onLayoutToggle, this.minExtent, this.maxExtent, this.food});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
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
        ),
        Positioned(
          right: 4.0,
          bottom: 4.0,
          child: SafeArea(
              child: FavouriteFoodIcon(
                  food: food, databaseProvider: SqlDatabaseProvider.db)),
        ),
      ],
    );
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
  FoodRoute({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.foodGroup),
      ),
      body: _scrollView(context),
    );
  }

  Widget _scrollView(BuildContext context) {
    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: HeroHeader(
                minExtent: 100.0,
                maxExtent: 300.0,
                food: food),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildListDelegate(<Widget>[
              Card(child: Text("${food.fructose} g")),
              Card(child: GlucoseFructoseGauge(food)),
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2,
            ),
            delegate: SliverChildListDelegate(<Widget>[
              Card(child: SugarsChart(food))
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2,
            ),
            delegate: SliverChildListDelegate(<Widget>[
              Card(child: Text("Lactose, Protein etc. go here ..."))
            ]),
          ),
        ],
      ),
    );
  }
}

// class FoodRoute extends StatelessWidget {
//   final Food food;

//   FoodRoute({Key key, this.food}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(food.description),
//       ),
//       body:
//         // Hero(
//         //   tag: food.description,
//         //   child: Image.asset(
//         //     food.imagePath,
//         //     width: 600,
//         //     fit: BoxFit.cover,
//         //   ),
//         // ),
//         GridView.count(
//           crossAxisCount: 2,
//           padding: EdgeInsets.all(12.0),
//           childAspectRatio: 8.0 / 9.0,
//           children: <Widget>[
//             Card(child: Text("${food.fructose} g")),
//             Card(child: GlucoseFructoseGauge(food)),
//             Card(child: SugarsChart(food))],
//         ),

//       // body: ListView(
//       //   children: [
//       //     Hero(
//       //       tag: food.description,
//       //       child: Image.asset(
//       //         food.imagePath,
//       //         width: 600,
//       //         fit: BoxFit.cover,
//       //       ),
//       //     ),
//       //     _buildTitleSection(food),
//       //     GlucoseFructoseGauge(food, 300, 300),
//       //     _buildNutrientListTile("Fructose", food.fructose),
//       //     _buildNutrientListTile("Glucose", food.glucose),
//       //     _buildNutrientListTile("Maltose", food.maltose),
//       //     _buildNutrientListTile("Sucrose", food.sucrose),
//       //     _buildNutrientListTile("Total Sugars", food.totalSugars),
//       //     _buildNutrientListTile("Lactose", food.lactose),
//       //     _buildNutrientListTile("Protein", food.protein),
//       //   ],
//       // ),
//     );
//   }
// }

// // TODO: add back in once migration to a grid is complete
// // ListTile _buildNutrientListTile(String title, num value) {
// //   return ListTile(
// //     trailing: Text("${value?.toStringAsFixed(1) ?? "?"} g"),
// //     title: Text(title),
// //   );
// // }
