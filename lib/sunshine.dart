import 'dart:math' as math;
import 'package:flutter/material.dart';

class Sunshine extends StatefulWidget {
  @override
  _SunshineState createState() => _SunshineState();
}

class _SunshineState extends State<Sunshine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        body: RaysAnimator());
  }
}

class RaysAnimator extends StatefulWidget {
  @override
  RaysAnimatorState createState() => RaysAnimatorState();
}

class RaysAnimatorState extends State<RaysAnimator> {
  int raysCount = 50;
  @override
  Widget build(BuildContext context) {
    final angleDifference = 2 * math.pi / raysCount;
    return Center(
      child: Stack(
        children: [
          Container(color: Colors.white, child: Circle()),
          Align(
              alignment: Alignment.center,
              child: RayBuilder(
                color: Colors.blue[300],
                angle: math.pi * 2 / 6, //angleDifference,
                length: 20,
                width: 5,
                position: Offset(0, 0),
              )),
        ],
      ),
    );
  }
}

class RayBuilder extends StatefulWidget {
  final double width;
  final double length;
  final Color color;
  final double angle;

  /// initial position
  final Offset position;

  const RayBuilder(
      {Key key,
      this.width = 4.0,
      this.length,
      this.color,
      this.angle,
      this.position})
      : super(key: key);

  @override
  _RayBuilderState createState() => _RayBuilderState();
}

class _RayBuilderState extends State<RayBuilder>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController.unbounded(
        vsync: this, duration: Duration(seconds: 10));
    _animationController.forward();
  }

  double gap = 5.0;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Raypainter(
          color: widget.color,
          length: widget.length,
          width: widget.width,
          angle: widget.angle),
    );
  }
}

class Raypainter extends CustomPainter {
  final Offset offset;
  final Color color;
  final double speed;
  final double angle;
  final double length;
  final double width;

  Raypainter(
      {this.speed,
      this.angle,
      this.offset,
      this.width,
      this.color,
      this.length});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double dx1 = centerX;
    double dy1 = centerY;
    double dx2 = dx1;
    double dy2 = dy1;
    double gapBetweenLines = 30.0;
    int noOfRaysAlongTheLine = 5;
    double dr = 0;

    for (int i = 0; i <= noOfRaysAlongTheLine; i++) {
      /// draw along the lines
      canvas.drawLine(Offset(dx1, dy1), Offset(dx2, dy2), linePaint);
      dr = i * (gapBetweenLines + length);
      dx1 = dr * math.cos(angle);
      dy1 = dr * math.sin(angle);
      dr = i * gapBetweenLines + (i - 1) * length;
      dx2 = dr * math.cos(angle);
      dy2 = dr * math.sin(angle);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class Circle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(),
      painter: CirclePainter(),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..strokeWidth = 10.0
      ..color = Colors.brown[900]
      ..style = PaintingStyle.stroke;

    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    canvas.drawCircle(Offset(centerX, centerY), 150.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
