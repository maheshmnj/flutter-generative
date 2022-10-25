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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    )..repeat();
    _animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double radius;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: CurvedAnimation(
              parent: _animationController, curve: Curves.fastOutSlowIn),
          builder: (context, child) {
            return CustomPaint(
              painter: RipplePainter(radius: 20 * _animationController.value),
              child: Container(),
            );
          }),
    );
    // }));
  }
}

/**https://medium.com/flutter-community/flutter-custom-painter-circular-wave-animation-bdc65c112690 */
class RipplePainter extends CustomPainter {
  RipplePainter({this.radius});
  double radius;
  
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Color.fromRGBO(97, 190, 162, 1.0)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    var currentRadius = radius;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double maxRadius = 2 * hypot(centerX, centerY);

    while (currentRadius < maxRadius) {
      canvas.drawCircle(Offset(centerX, centerY), currentRadius, paint);
      currentRadius += 20.0;
    }
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) {
    return true; //oldDelegate.radius != radius;
  }

  double hypot(double x, double y) {
    return math.sqrt(x * x + y * y);
  }
}
