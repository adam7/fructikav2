import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';

class SettingsRoute extends StatelessWidget {
  final PreferencesHelper preferencesHelper;

  SettingsRoute({Key key, @required this.preferencesHelper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Titles.settingsTitle)),
        body: Column(
          children: <Widget>[ShowUnknownSwitchListTile(preferencesHelper), WarningLevelSlider(preferencesHelper)],
        ),
        drawer: AppDrawer());
  }
}

class WarningLevelSlider extends StatefulWidget {
  final PreferencesHelper preferencesHelper;

  WarningLevelSlider(this.preferencesHelper) : super();
  @override
  _WarningLevelSliderState createState() => _WarningLevelSliderState();
}

class _WarningLevelSliderState extends State<WarningLevelSlider> {
  double warningLevel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
        future: SharedPreferencesHelper().getWarningLevel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Slider(
                label: warningLevel.toString(),
                value: warningLevel = snapshot.data,
                min: 1,
                max: 30,
                divisions: 60,
                onChangeEnd: (value) {},
                onChanged: (value) {
                  setState(() {
                    warningLevel = value;
                  });
                  widget.preferencesHelper.setWarningLevel(value);
                });
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
