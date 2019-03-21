import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutRoute extends StatelessWidget {
  final String title;
  final imageContributors = [
    "@nhillier",
    "@mjtangonan",
    "@jonathanpielmayer",
    "@georgiavagim",
    "@mero_dnt",
    "@promotion",
    "@unibodies",
    "@jorgezapatag",
    "@daviidstreit",
    "@neonbrand",
    "@the_alp_photography",
    "@sylvanusurban",
    "@danielcgold",
    "@daen_2chinda",
    "@oldskool2016",
    "@m15ky",
    "@heftiba",
    "@romankraft",
    "@eaterscollective",
    "@foodiesfeed",
    "@miroslava"
  ];

  AboutRoute({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Column(children: <Widget>[
          Expanded(
              child: Card(
                  child: ListView.builder(
                      itemCount: imageContributors.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                          title: Text(imageContributors[index]),
                          trailing: IconButton(
                              icon: Icon(Icons.open_in_browser),
                              onPressed: () => launch("https://unsplash.com/${imageContributors[index]}")),
                        );
                      })))
        ]),
        drawer: AppDrawer());
  }
}
