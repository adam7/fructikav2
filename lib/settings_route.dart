import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';

class SettingsRoute extends StatelessWidget {
  final PreferencesHelper preferencesHelper;

  SettingsRoute({Key key, @required this.preferencesHelper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FructikaAppBar(title: Text(Titles.settingsTitle)),
        body: Column(
          children: <Widget>[
            ShowUnknownSwitchListTile(preferencesHelper),
            Divider(),
            WarningLevelDropdownListTile(preferencesHelper),
            Divider()
          ],
        ),
        drawer: AppDrawer());
  }
}

class WarningLevelDropdownListTile extends StatelessWidget {
  final PreferencesHelper preferencesHelper;
  final _itemValues = List<double>.generate(18, (index) => 2.0 + index);

  WarningLevelDropdownListTile(this.preferencesHelper) : super();

  _getItems() {
    return _itemValues
        .map((value) => DropdownMenuItem<double>(
            value: value, child: Text("${value.toStringAsFixed(1)} g")))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
        future: preferencesHelper.getWarningLevel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListTile(
                title: Text("Fructose warning level"),
                trailing: DropdownButton<double>(
                    value: snapshot.data,
                    onChanged: (double value) {
                      preferencesHelper.setWarningLevel(value);
                    },
                    items: _getItems()));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class ShowUnknownSwitchListTile extends StatelessWidget {
  final PreferencesHelper preferencesHelper;

  ShowUnknownSwitchListTile(this.preferencesHelper) : super();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: preferencesHelper.getShowUnknown(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SwitchListTile(
              title: Text("Show unknown fructose"),
              value: snapshot.data,
              onChanged: (bool value) {
                preferencesHelper.setShowUnknown(value);
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

