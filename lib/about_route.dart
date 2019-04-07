import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AboutRoute extends StatelessWidget {
  final String title;

  AboutRoute({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView(
          children: <Widget>[
            Image.asset(
              "images/dan-novac-629278-unsplash.jpg",
              width: 600,
              fit: BoxFit.scaleDown,
            ),
            Container(
                padding: EdgeInsets.all(8),
                child: Text("Fructika is made with ❤ in beautiful Budapest",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Container(
                padding: EdgeInsets.all(8),
                child: Text("Find out more on the web",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            buttonSection,
            Container(
                padding: EdgeInsets.all(8),
                child: Text("All code is GPL3")),
            Container(
                padding: EdgeInsets.all(8),
                child: Text("All images are Unsplash License")),
            ExpansionTile(
                key: PageStorageKey('imagecredits'),
                title: Text('Image credits'),
                children: _buildContributorListTiles()),
          ],
        ),
        drawer: AppDrawer());
  }
}

final imageContributors = [
  "@dnovac",
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

List<Widget> _buildContributorListTiles() {
  List<ListTile> contributorListTiles = List<ListTile>();

  for (var contributor in imageContributors) {
    contributorListTiles.add(ListTile(
      title: Text(contributor),
      trailing: IconButton(
          icon: Icon(Icons.open_in_browser),
          onPressed: () => launch("https://unsplash.com/$contributor")),
    ));
  }

  return contributorListTiles;
}

Widget buttonSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(MdiIcons.twitterCircle, 'Twitter'),
      _buildButtonColumn(MdiIcons.githubCircle, 'GitHub'),
      _buildButtonColumn(MdiIcons.web, 'Web'),
    ],
  ),
);

Column _buildButtonColumn(IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    ],
  );
}
