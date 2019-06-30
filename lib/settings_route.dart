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
            ListTile(
                title: Text("Fructose warning level"),
                trailing: WarningLevelDropdown(preferencesHelper)),
          ],
        ),
        drawer: AppDrawer());
  }
}

class WarningLevelDropdown extends StatefulWidget {
  final PreferencesHelper preferencesHelper;

  WarningLevelDropdown(this.preferencesHelper) : super();
  @override
  _WarningLevelDropdownState createState() => _WarningLevelDropdownState();
}

class _WarningLevelDropdownState extends State<WarningLevelDropdown> {
  double warningLevel;
  final _itemValues = List<double>.generate(18, (index) => 2.0 + index);

  List<DropdownMenuItem<double>> getItems() {
    return _itemValues
        .map((value) => DropdownMenuItem<double>(
            value: value, child: Text("${value.toStringAsFixed(1)} g")))
        .toList();
  }

  _ensureValidValue(double value) {
    return _itemValues.contains(value) ? value : null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
        future: widget.preferencesHelper.getWarningLevel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<double>(
                value: _ensureValidValue(warningLevel),
                onChanged: (double value) {
                  setState(() {
                    warningLevel = value;
                  });
                  widget.preferencesHelper.setWarningLevel(value);
                },
                items: getItems());
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
                SharedPreferencesHelper().setShowUnknown(value);
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
