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
            WarningLevelSlider(preferencesHelper),
            Divider(),
            ShowUnknownSwitchListTile(preferencesHelper),
            Divider(),
            // WarningLevelDropdownListTile(preferencesHelper),
            Divider()
          ],
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
        future: widget.preferencesHelper.getWarningLevel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            warningLevel = snapshot.data;
            String formattedWarningLevel =
                "${warningLevel.toStringAsFixed(1)} g";
            return Column(children: <Widget>[
              ListTile(
                  title: Text("Fructose Warning Level"),
                  trailing: Text(formattedWarningLevel)),
              Slider(
                  label: formattedWarningLevel,
                  divisions: 40,
                  min: 0,
                  max: 20,
                  value: warningLevel,
                  onChanged: (double value) {
                    widget.preferencesHelper.setWarningLevel(value);
                    setState(() {
                      warningLevel = value;
                    });
                  })
            ]);
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
