import 'package:flutter/material.dart';
import 'package:fructika/about_route.dart';
import 'package:fructika/database/sql_database_provider.dart';
import 'package:fructika/favourites_route.dart';
import 'package:fructika/food_group_route.dart';
import 'package:fructika/search_route.dart';
import 'package:fructika/settings_route.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset('images/icon.png')            
          ),
          _buildListTile(
              context, SearchRoute(SqlDatabaseProvider.db), Titles.foodSearchTitle, Icons.search),
          _buildListTile(context, FavouritesRoute(), Titles.favouriteTitle,
              Icons.favorite),
          _buildListTile(
              context, FoodGroupRoute(SqlDatabaseProvider.db), Titles.foodGroupTitle, Icons.group),
          _buildListTile(
              context, SettingsRoute(preferencesHelper: SharedPreferencesHelper()), Titles.settingsTitle, Icons.settings),
          _buildListTile(context, AboutRoute(), Titles.aboutTitle, Icons.info)
        ],
      ),
    );
  }

  ListTile _buildListTile(
      BuildContext context, Widget widget, String title, IconData iconData) {
    return ListTile(
        leading: Icon(iconData),
        title: Text(title),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => widget));
        });
  }
}
