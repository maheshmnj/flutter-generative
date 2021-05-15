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
  int raysCount = 10;
  @override
  Widget build(BuildContext context) {
    final angleDifference = 2 * math.pi / raysCount;
    return Center(
      child: Stack(
        children: [
          Circle(),
          for (int i = 1; i < 10; i++)
            Align(
                alignment: Alignment.center,
                child: RayBuilder(
                  color: Colors.orange[300],
                  angle: angleDifference * i,
                  length: 80,
                  width: 15,
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
  final Offset position;

  const RayBuilder(
      {Key key, this.width, this.length, this.color, this.angle, this.position})
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
    return Stack(
      children: [
        for (int i = 1; i < 20; i++)
          Transform.rotate(
            angle: widget.angle,
            child: CustomPaint(
              painter: Raypainter(
                  offset: Offset(i + 50.0, math.tan(math.pi / 4) * (i + 50)),
                  color: Colors.orange[300]),
            ),
            // child: Transform.translate(
            //     offset: Offset(i + 60.0, math.tan(math.pi / 4) * (i + 50)),
            //     child: ),
          ),
      ],
    );
  }
}

class Raypainter extends CustomPainter {
  final Offset offset;
  final Color color;

  Raypainter({this.offset, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint linePaint = Paint()..color = color;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double dx = centerX;
    double dy = centerY;
    double gapBetweenLines = 5.0;
    for (int i = 1; i < 10; i++) {
      /// draw along the lines
      dx = dx + gapBetweenLines;
      dy = dy + gapBetweenLines;
      canvas.drawRect(
          Rect.fromPoints(Offset(40, 0), Offset(50, math.tan(60))), linePaint);
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
