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
    final int numberOfAngles = 60;
    return Center(
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: RayBuilder(
                numberOfAngles: numberOfAngles, //angleDifference,
              )),
          Container(child: Circle()),
        ],
      ),
    );
  }
}

class RayBuilder extends StatefulWidget {
  final int numberOfAngles;

  const RayBuilder({Key key, this.numberOfAngles}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Raypainter(numberOfAngles: widget.numberOfAngles),
    );
  }
}

class Raypainter extends CustomPainter {
  final double speed;
  final int numberOfAngles;

  Raypainter({
    this.speed,
    this.numberOfAngles,
  });

  List<Color> lineColors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.brown,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.cyanAccent,
    Colors.blueGrey
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint linePaint = Paint()..strokeCap = StrokeCap.round;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double dx1 = centerX;
    double dy1 = centerY;
    double dx2 = dx1;
    double dy2 = dy1;
    int noOfRaysAlongTheLine = 5;
    double dr = 0;
    for (int y = 1; y <= numberOfAngles; y++) {
      double angle = y * (360 / numberOfAngles * math.pi / 180);
      for (int i = 0; i <= noOfRaysAlongTheLine; i++) {
        /// draw along the lines
        linePaint..color = lineColors[math.Random().nextInt(lineColors.length)];
        linePaint..strokeWidth = nextInteger(5, 8).toDouble();
        int length = nextInteger(20, 50);
        double gapBetweenLines = nextInteger(30, 50).toDouble();
        canvas.drawLine(Offset(dx1, dy1), Offset(dx2, dy2), linePaint);
        dr = i * (gapBetweenLines + length);
        dx1 = dr * math.cos(angle);
        dy1 = dr * math.sin(angle);
        dr = i * gapBetweenLines + (i - 1) * length;
        dx2 = dr * math.cos(angle);
        dy2 = dr * math.sin(angle);
      }
    }
  }

  int nextInteger(int min, int max) => min + math.Random().nextInt(max - min);

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
    paint.style = PaintingStyle.fill;
    paint.color = Colors.white;
    canvas.drawCircle(Offset(centerX, centerY), 145.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
