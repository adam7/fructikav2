import 'package:flutter/material.dart';

class FructikaAppBar extends AppBar {
  FructikaAppBar({Key key, Widget title})
      : super(
          key: key,
          title: title,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          )
        );
}
