import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/food_route.dart';

class SearchRoute extends StatelessWidget {
  final String title;

  SearchRoute({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: RandomWords(),
        drawer: AppDrawer()
        );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();

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

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}