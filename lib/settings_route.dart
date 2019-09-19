import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:provider/provider.dart';

class SettingsRoute extends StatelessWidget {
  SettingsRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FructikaAppBar(title: Text(Titles.settingsTitle)),
        body: Column(
          children: <Widget>[
            WarningLevelSlider(),
            Divider(),
            ShowUnknownSwitchListTile(),
            Divider()
          ],
        ),
        drawer: AppDrawer());
  }
}

class WarningLevelSlider extends StatefulWidget {
  WarningLevelSlider() : super();

  @override
  _WarningLevelSliderState createState() => _WarningLevelSliderState();
}

class _WarningLevelSliderState extends State<WarningLevelSlider> {
  double warningLevel;

  @override
  Widget build(BuildContext context) {
    final preferencesHelper = Provider.of<PreferencesHelper>(context);

    return FutureBuilder<double>(
        future: preferencesHelper.getWarningLevel(),
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
                    preferencesHelper.setWarningLevel(value);
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
  @override
  Widget build(BuildContext context) {
    final preferencesHelper = Provider.of<PreferencesHelper>(context);

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