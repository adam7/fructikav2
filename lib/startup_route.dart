import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/database/migrator.dart';
import 'package:fructika/search_route.dart';
import 'package:fructika/widgets/startup_background.dart';
import 'package:provider/provider.dart';

class StartupRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    final migrator = Migrator(repository.database, 1, rootBundle);
    migrator.migrate();

    return StreamBuilder<MigrationStatus>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SearchRoute(true)));
            });
          }

          return Scaffold(
              body: Center(
                  child: Stack(children: <Widget>[
            StartupBackground(),
            _startupColumn(snapshot)
          ])));
        },
        stream: migrator.stream,
        initialData: MigrationStatus(0, ""));
  }

  Widget _startupColumn(AsyncSnapshot<MigrationStatus> snapshot) {
    if (snapshot.hasData) {
      return Column(
        children: <Widget>[
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedText(snapshot.data.message)),
            flex: 1,
          ),
          Expanded(
              child: SpinKitDoubleBounce(
                color: Colors.white30,
                size: 50.0,
              ),
              flex: 1),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset("images/undraw_cookie_love_ulvn.svg")),
            flex: 3,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

class AnimatedText extends StatefulWidget {
  final String message;
  AnimatedText(this.message);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        reverseDuration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    _controller.reset();
    _controller.forward();
    return FadeTransition(
        child: Text(widget.message,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white)),
        opacity: Tween(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(curve: Curves.easeIn, parent: _controller)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


