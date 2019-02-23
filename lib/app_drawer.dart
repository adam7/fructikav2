import 'package:flutter/material.dart';
import 'package:fructika/about_route.dart';
import 'package:fructika/food_group_route.dart';
import 'package:fructika/search_route.dart';
import 'package:fructika/settings_route.dart';

class AppDrawer extends StatelessWidget {
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
            title: Text('Food Search'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchRoute(title: "Search")));
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Food Groups'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FoodGroupRoute(title: "Food Groups")));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(                  context,                  MaterialPageRoute(
                      builder: (context) => SettingsRoute(title: "Settings")));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutRoute(title: "Settings")));
            },
          ),
        ],
      ),
    );
  }
}
