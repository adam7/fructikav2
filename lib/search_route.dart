import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/database.dart';
import 'package:fructika/food_route.dart';
import 'package:fructika/models/food.dart';
import 'package:material_search/material_search.dart';
import 'dart:math' as math;

const _list = const [
  'Igor Minar',
  'Brad Green',
  'Dave Geddes',
  'Naomi Black',
  'Greg Weber',
  'Dean Sofer',
  'Wes Alvaro',
  'John Scott',
  'Daniel Nadasi',
];

class SearchRoute extends StatefulWidget {
  final String title;

  SearchRoute({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final TextEditingController _search = new TextEditingController();

  List<Food> foods = List<Food>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
          controller: _search,
          onSubmitted: (text) {
            if (text.isEmpty) {
              foods = List<Food>();
              setState(() {
                
              });
            } else {
              DBProvider.db.getAllFoods().then((result) {
                foods = result;
                setState(() {});
              });
            }
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              suffixIcon: Icon(Icons.search)),
        )),
        body: ListView.separated(
            itemCount: foods.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          Image.asset('images/group_271121.jpg').image),
                  title: Text(
                    foods[index].description,
                    style: _biggerFont,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      // Add the lines from here...
                      foods[index].favourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: foods[index].favourite ? Colors.red : null,
                    ),
                    onPressed: () {
                      DBProvider.db.toggleFavourite(foods[index]);
                      setState(() {});
                    },
                  ));
            }),

        // FutureBuilder<List<Food>>(
        //   future: DBProvider.db.getAllFoods(),
        //   builder: (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: snapshot.data.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           Food item = snapshot.data[index];
        //           return Dismissible(
        //               key: UniqueKey(),
        //               background: Container(color: Colors.red),
        //               onDismissed: (direction) {
        //                 DBProvider.db.deleteFood(item.id);
        //               },
        //               child: ListTile(
        //                 leading: CircleAvatar(
        //                     backgroundImage:
        //                         Image.asset('images/group_271121.jpg').image),
        //                 title: Text(
        //                   item.description,
        //                   style: _biggerFont,
        //                 ),
        //                 trailing: IconButton(
        //                   icon: Icon(
        //                     // Add the lines from here...
        //                     item.favourite
        //                         ? Icons.favorite
        //                         : Icons.favorite_border,
        //                     color: item.favourite ? Colors.red : null,
        //                   ),
        //                   onPressed: () {
        //                     DBProvider.db.toggleFavourite(item);
        //                     setState(() {});
        //                   },
        //                 ),
        //                 onTap: () {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => FoodRoute()));
        //                 },
        //               ));
        //         },
        //       );
        //     } else {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            // Food rnd = testFoods[math.Random().nextInt(testFoods.length)];
            // await DBProvider.db.newFood(rnd);
            // setState(() {});
          },
        ),
        drawer: AppDrawer());
  }
}

class FoodsWidget extends StatefulWidget {
  @override
  FoodsWidgetState createState() => new FoodsWidgetState();
}

class FoodsWidgetState extends State<FoodsWidget> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<Food>();

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      leading: CircleAvatar(
          backgroundImage: Image.asset('images/group_271121.jpg').image),
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FoodRoute()));
      },
      // onTap: () {
      //   // Add 9 lines from here...
      //   setState(() {
      //     if (alreadySaved) {
      //       _saved.remove(pair);
      //     } else {
      //       _saved.add(pair);
      //     }
      //   });
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }
}

class FoodListTile extends ListTile {
  _build() {}
}
