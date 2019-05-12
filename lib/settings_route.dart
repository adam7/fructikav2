import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/titles.dart';

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Titles.settingsTitle)),
        body: Column(
          children: <Widget>[
            SwitchListTile(
              title: Text("Show unknown fructose"),
              value: false,
              onChanged: (bool value) {},
            ),
            Slider(label:"Fructose warning level", value: 10, min: 1, max: 30, onChanged: (double value) { },)
          ],
        ),
        drawer: AppDrawer());
  }
}
