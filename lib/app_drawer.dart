import 'package:flutter/material.dart';
import 'package:fructika/about_route.dart';
import 'package:fructika/food_group_route.dart';
import 'package:fructika/search_route.dart';
import 'package:fructika/settings_route.dart';

class AppDrawer extends StatelessWidget {
  final String _foodGroupTitle = "Food Groups";
  final String _foodSearchTitle = "Food Search";
  final String _settingsTitle = "Settings";
  final String _aboutTitle = "About";

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
          ListTile(
            leading: Icon(Icons.search),
            title: Text(_foodSearchTitle),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchRoute(title: _foodSearchTitle)));
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text(_foodGroupTitle),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FoodGroupRoute(title: _foodGroupTitle)));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(_settingsTitle),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingsRoute(title: _settingsTitle)));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(_aboutTitle),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutRoute(title: _aboutTitle)));
            },
          ),
        ],
      ),
    );
  }
}
