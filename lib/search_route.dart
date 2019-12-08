import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/utilities/shared_preferences_helper.dart';
import 'package:fructika/utilities/titles.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/widgets/food_list.dart';
import 'package:fructika/models/food.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:provider/provider.dart';

class SearchRoute extends StatefulWidget {
  final bool _showDrawer;

  SearchRoute(this._showDrawer, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchRouteState(this._showDrawer);
}

class SearchRouteState extends State<SearchRoute> {
  final bool _showDrawer;
  final TextEditingController _search = new TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<Food> foods = List<Food>();

  SearchRouteState(this._showDrawer);

  void initState() {
    super.initState();

    if (_showDrawer) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showDrawer(context));
    }
  }

  showDrawer(BuildContext context) {
    _key.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesHelper = Provider.of<PreferencesHelper>(context);
    final repository = Provider.of<Repository>(context);

    return Scaffold(
        key: _key,
        appBar: FructikaAppBar(
            title: TextField(
                controller: _search,
                onSubmitted: (text) {},
                onChanged: (text) async {
                  if (text.isEmpty || text.length < 3) {
                    setState(() {
                      foods = [];
                    });
                  } else {
                    var results =
                        await repository.searchFoods(text, preferencesHelper);

                    setState(() {
                      foods = results;
                    });
                  }
                },
                textInputAction: TextInputAction.search,
                autofocus: !_showDrawer,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: Titles.foodSearchTitle))),
        body: FoodList(foods: foods),
        drawer: AppDrawer());
  }
}
