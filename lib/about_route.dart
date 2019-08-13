import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fructika/app_drawer.dart';
import 'package:fructika/titles.dart';
import 'package:fructika/widgets/fructika_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            Image.asset("images/dan-novac-629278.jpg"),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Fructika is made with ❤",
                        style: textTheme.title.copyWith(color: Colors.white70),
                        textAlign: TextAlign.center))),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("in beautiful Budapest",
                      style: textTheme.title.copyWith(color: Colors.white70),
                      textAlign: TextAlign.center)),
            ),
          ],
        ));
  }
}

class FaqWidget extends StatelessWidget {
  final String question;
  final String answer;
  final IconData iconData;
  final String url;

  FaqWidget(this.question, this.answer, this.iconData, this.url);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(question, style: textTheme.subtitle)),
                // Divider(),
                Row(children: <Widget>[
                  Expanded(child: Text(answer)),
                  IconButton(
                      alignment: Alignment.topCenter,
                      icon: Icon(iconData),
                      onPressed: () => launch(url)),
                ]),
              ],
            )));
  }
}

class AboutRoute extends StatelessWidget {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: FructikaAppBar(title: Text(Titles.aboutTitle)),
        body: ListView(controller: _controller, children: <Widget>[
          HeaderCard(),
          Align(alignment: Alignment.center, child: Text(
            "FAQ",
            style: textTheme.title,
          )),
          FaqWidget(
              "Something's not working properly how can I let you know?",
              "You can send me an email via fructikapp@gmail.com",
              Icons.email,
              "mailto:fructikapp@gmail.com"),
          FaqWidget(
              "Send an email, what is this the 90s?",
              "Fair point, you can get in touch on twitter too of course @adm_cpr",
              MdiIcons.twitter,
              "https://twitter.com/adm_cpr"),
          FaqWidget(
              "Where does the Fructika data come from?",
              "Currently Fructika uses data from the USDA Food Composition Database.",
              Icons.open_in_browser,
              "https://ndb.nal.usda.gov/ndb/"),
          FaqWidget(
              "Can I contribute to make the Fructika app better?",
              "Yes please! 😻 The source code is available on GitHub and and all contributions are very welcome.",
              MdiIcons.githubCircle,
              "https://github.com/adam7/fructikav2"),
          FaqWidget(
              "Where did you get that sweet illustration for the Fructika icon?",
              "It came from the lovely people at unDraw.",
              Icons.open_in_browser,
              "https://undraw.co"),
          FaqWidget(
              "Where did you get all those beautiful food group photos for Fructika and how are they licensed?",
              "All the photos come from the unsplash website, I've linked the users who contributed below. All photos used for food groups are Unsplash Licensed.",
              Icons.open_in_browser,
              "https://unsplash.com"),
          ExpansionTile(
              key: PageStorageKey('photocredits'),
              title: Text('Photo credits'),
              children: _buildContributorListTiles()),
        ]),
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

List<ListTile> _buildContributorListTiles() {
  return imageContributors
      .map((contributor) => ListTile(
            title: Text(contributor),
            trailing: IconButton(
                icon: Icon(Icons.open_in_browser),
                onPressed: () => launch("https://unsplash.com/$contributor")),
          ))
      .toList();
}
