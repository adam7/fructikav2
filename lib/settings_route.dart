import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';

class SettingsRoute extends StatelessWidget {
  final String title;

  SettingsRoute({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Column(
          children: <Widget>[
            SwitchListTile(
              title: Text("Show unknown frcutose"),
              value: false,
              onChanged: (bool value) {},
            ),
            Slider(label:"Fructose warning level", value: 10, min: 1, max: 30, onChanged: (double value) { },)
          ],
        ),
        drawer: AppDrawer());
  }
}
