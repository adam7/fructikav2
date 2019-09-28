import 'package:flutter/material.dart';
import 'package:fructika/utilities/theme_data.dart';

class StartupBackground extends StatefulWidget {
  @override
  _StartupBackground createState() => _StartupBackground();
}

class _StartupBackground extends State<StartupBackground>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: fructikaPrimaryDark,
        end: fructikaPrimaryLight,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: fructikaPrimaryLight,
        end: fructikaPrimaryDark,
      ),
    )
  ]);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Scaffold(
            body: Container(
              color: background
                  .evaluate(AlwaysStoppedAnimation(_controller.value)),
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// import "package:flutter/material.dart";
// import 'package:fructika/utilities/theme_data.dart';
// import "package:simple_animations/simple_animations.dart";

// class StartupBackground extends StatelessWidget {
//   final colorName1 = "color1";
//   final colorName2 = "color2";

//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTrackTween([
//       Track(colorName1).add(Duration(seconds: 3),
//           ColorTween(begin: fructikaPrimary, end: fructikaPrimaryLight)),
//       Track(colorName2).add(Duration(seconds: 3),
//           ColorTween(begin: fructikaPrimaryDark, end: fructikaPrimary))
//     ]);

//     return ControlledAnimation(
//       playback: Playback.MIRROR,
//       tween: tween,
//       duration: tween.duration,
//       builder: (context, animation) {
//         return Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [animation[colorName1], animation[colorName2]])),
//         );
//       },
//     );
//   }
// }
