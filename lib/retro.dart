import 'dart:math';

import 'package:flutter/material.dart';

class RetroArt extends StatefulWidget {
  @override
  _RetroArtState createState() => _RetroArtState();
}

class _RetroArtState extends State<RetroArt>
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
        seconds: 2,
      ),
    );

    animation = Tween<double>(
      begin: 0,
      end: pi / 8,
    ).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(seconds: 2), () {
            _animationController.reset();
            _animationController.forward(from: 0.0);
          });
        }
      });
    // ..repeat(period: Duration(seconds: 2));

    _animationController.forward();
  }

  double angle = pi / 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            // for (int i = 0; i < 10; i++)
            RetroWheel(
              lines: 8,
              radius: 40,
              animation: animation,
            )
          ],
        ));
  }
}

class RetroWheel extends StatefulWidget {
  final int lines;
  final int radius;
  final Animation<double> animation;

  const RetroWheel({Key key, this.lines, this.radius, this.animation})
      : super(key: key);
  @override
  _RetroWheelState createState() => _RetroWheelState();
}

class _RetroWheelState extends State<RetroWheel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("rebuild");
  }

  @override
  Widget build(BuildContext context) {
    print(widget.animation.value);
    return Center(
      child: AnimatedBuilder(
          animation: widget.animation,
          builder: (BuildContext context, Widget w) {
            return Transform.rotate(
              angle: widget.animation.value * (pi / 8),
              child: CustomPaint(
                painter: RetroPainter(40.0, 160.0),
              ),
            );
          }),
    );
  }
}

class RetroPainter extends CustomPainter {
  final double innerRadius;
  final double outerRadius;

  RetroPainter(this.innerRadius, this.outerRadius);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5;

    // double centerX = size.width / 2.0;
    // double centerY = size.height / 2.0;
    // Offset center = Offset(centerX, centerY);
    int noOfLines = 8;
    final initDegree = 360 / noOfLines;
    for (int i = 1; i <= noOfLines; i++) {
      final degree = initDegree * (pi / 180) * i;
      double dx1 = innerRadius * cos(degree);
      double dy1 = innerRadius * sin(degree);
      double dx2 = outerRadius * cos(degree);
      double dy2 = outerRadius * sin(degree);
      Offset p1 = Offset(dx1, dy1);
      Offset p2 = Offset(dx2, dy2);
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
