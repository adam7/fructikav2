import 'package:flutter/material.dart';
import 'package:fructika/about_route.dart';
import 'package:fructika/favourites_route.dart';
import 'package:fructika/food_group_route.dart';
import 'package:fructika/search_route.dart';
import 'package:fructika/settings_route.dart';

class AppDrawer extends StatelessWidget {
  final String _foodGroupTitle = "Food Groups";
  final String _foodSearchTitle = "Food Search";
  final String _settingsTitle = "Settings";
  final String _aboutTitle = "About";
  final String _favouriteTitle = "Favourites";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Fructika'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          _buildListTile(context, SearchRoute(title: _foodSearchTitle),
              _foodSearchTitle, Icons.search),
          _buildListTile(context, FavouritesRoute(title: _favouriteTitle),
              _favouriteTitle, Icons.favorite),
          _buildListTile(context, FoodGroupRoute(title: _foodGroupTitle),
              _foodGroupTitle, Icons.group),
          _buildListTile(context, SettingsRoute(title: _settingsTitle),
              _settingsTitle, Icons.settings),
          _buildListTile(
              context, AboutRoute(title: _aboutTitle), _aboutTitle, Icons.info)
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
