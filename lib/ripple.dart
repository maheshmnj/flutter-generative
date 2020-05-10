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
        seconds: 100,
      ),
    )..repeat();
    animation = Tween<double>(
      begin: 10,
      end: 10000,
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
    canvas.drawCircle(c, radius % (1000), paint);
    canvas.drawCircle(c, radius % (950), paint);
    canvas.drawCircle(c, radius % (900), paint);
    canvas.drawCircle(c, radius % (850), paint);
    canvas.drawCircle(c, radius % (850), paint);
    canvas.drawCircle(c, radius % (800), paint);
    canvas.drawCircle(c, radius % (750), paint);
    canvas.drawCircle(c, radius % (700), paint);
    canvas.drawCircle(c, radius % (650), paint);
    canvas.drawCircle(c, radius % (600), paint);
    canvas.drawCircle(c, radius % (550), paint);
    canvas.drawCircle(c, radius % (500), paint);
    // canvas.drawCircle(c, radius % (500), paint);
    // canvas.drawCircle(c, radius % (500), paint);
    // canvas.drawCircle(c, radius % (500), paint);

    // canvas.drawCircle(c, radius % (25 * 1), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
  // TODO: implement shouldRepaint

}
