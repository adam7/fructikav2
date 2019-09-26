import "package:flutter/material.dart";
import 'package:fructika/utilities/theme_data.dart';
import "package:simple_animations/simple_animations.dart";

class StartupBackground extends StatelessWidget {
  final colorName1 = "color1";
  final colorName2 = "color2";

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track(colorName1).add(Duration(seconds: 3),
          ColorTween(begin: fructikaPrimary, end: fructikaPrimaryLight)),
      Track(colorName2).add(Duration(seconds: 3),
          ColorTween(begin: fructikaPrimaryDark, end: fructikaPrimary))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [animation[colorName1], animation[colorName2]])),
        );
      },
    );
  }
}
