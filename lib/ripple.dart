import 'dart:math' as math;

import 'package:flutter/material.dart';

/** Inspiration
 * https://twitter.com/etiennejcb/status/1213781328426127362
 *  */
class RippleEffect extends StatefulWidget {
  @override
  _RippleEffectState createState() => _RippleEffectState();
}

class _RippleEffectState extends State<RippleEffect>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 50,
      ),
    )..repeat();
    animation = Tween<double>(
      begin: 10,
      end: 500,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {
          radius = _animationController.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });

    _animationController.forward();
  }

  double radius;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: CanvasPainter(radius: animation.value),
        child: Container(),
      ),
    );
    // }));
  }
}

/**https://medium.com/flutter-community/flutter-custom-painter-circular-wave-animation-bdc65c112690 */
class CanvasPainter extends CustomPainter {
  CanvasPainter({this.radius});
  double radius;
  @override
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Color.fromRGBO(97, 190, 162, 1.0)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    final c = size.center(Offset.zero);
    // for (int i = 0; i < 1000; i++) {
    //   canvas.drawCircle(c, radius % (i * 15), paint);
    // }
    var currentRadius = radius;
//     while (currentRadius < 100) {
//       canvas.drawCircle(c, currentRadius, paint);
//       currentRadius += 10.0;
//     }
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double maxRadius = hypot(centerX, centerY);

    while (currentRadius < maxRadius) {
      canvas.drawCircle(Offset(centerX, centerY), currentRadius, paint);
      currentRadius += 10.0;
    }
  }

  @override
  bool shouldRepaint(CanvasPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }

  double hypot(double x, double y) {
    return math.sqrt(x * x + y * y);
  }
}
