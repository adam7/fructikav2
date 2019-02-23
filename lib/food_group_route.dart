import 'package:flutter/material.dart';
import 'package:fructika/app_drawer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FoodGroupRoute extends StatelessWidget {
  final String title;
  bool _enabled = false;

  FoodGroupRoute({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'images/group_271121.jpg',
                    width: 600,
                    fit: BoxFit.scaleDown,                    
                  ),
                  SwitchListTile(
                      title: Text('Fruit and Fruit Juices'),
                      subtitle: const Text('Enabled'),
                      value: _enabled,
                      onChanged: (bool value) {
                        _enabled = value;
                      })
                ],
              ),
            );
          },
          itemCount: 10,
          viewportFraction: 0.9,
          scale: 0.9,
          pagination: SwiperPagination(),
        ),
        drawer: AppDrawer());
  }
}

