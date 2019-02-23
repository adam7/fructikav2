import 'package:flutter/material.dart';

class FoodRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food details"),
      ),
      body: Column(
        children: [
          Image.asset(
               'images/group_271121.jpg',
               width: 600,
               fit: BoxFit.cover,
             ), 
          titleSection,
        ],
      ),
    );
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      Icon(
        Icons.favorite,
        color: Colors.red[500],
      ),
    ],
  ),
);
