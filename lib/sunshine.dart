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
    final int numberOfAngles = 50;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: RayBuilder(
            numberOfAngles: numberOfAngles, //angleDifference,
          ),
        ),
        Circle(),
      ],
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
  Animation<double> _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        value: 0.0, vsync: this, duration: Duration(seconds: 4));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          return CustomPaint(
            painter: Raypainter(
                numberOfAngles: widget.numberOfAngles,
                animationSpeed: _animationController.value * 10),
          );
        });
  }
}

class Raypainter extends CustomPainter {
  final double animationSpeed;
  final int numberOfAngles;

  Raypainter({this.animationSpeed, this.numberOfAngles});

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
    int noOfRaysAlongTheLine = 10;
    double gapBetweenLines = 15;
    double dr = 0;
    double innerRadius = 200;
    linePaint..strokeWidth = 5;
    for (int i = 0; i < numberOfAngles; i++) {
      double angle = i * (2 * math.pi / numberOfAngles);
      double x = centerX + innerRadius * math.cos(angle);
      double y = centerY + innerRadius * math.sin(angle);
      linePaint.color = lineColors[i % lineColors.length];
      canvas.drawLine(Offset(centerX, centerY), Offset(x, y), linePaint);
    }
    for (int i = 0; i < 10; i++) {
      // int index = math.Random().nextInt(lineColors.length);
      // linePaint..color = lineColors[index];
      double angle = i * math.pi / 4;
      double dx1 = animationSpeed * innerRadius * math.cos(angle);
      double dy1 = animationSpeed * innerRadius * math.sin(angle);
      double dx2 = animationSpeed * (50 + innerRadius) * math.cos(angle);
      double dy2 = animationSpeed * (50 + innerRadius) * math.sin(angle);
      Offset p1 = Offset(dx1, dy1);
      Offset p2 = Offset(dx2, dy2);
      canvas.drawLine(p1, p2, linePaint);
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
