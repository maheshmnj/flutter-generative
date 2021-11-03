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
  int raysCount = 1;
  void _incrementCounter() {
    setState(() {
      raysCount++;
    });
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: RayBuilder(
              numberOfAngles: raysCount, //angleDifference,
            ),
          ),
          // Circle(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
          ),
          FloatingActionButton(
              key: Key('increment'),
              onPressed: _incrementCounter,
              tooltip: 'ball Animation',
              child: Icon(Icons.radio_button_checked)),
        ],
      ),
    );
  }
}

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
    // noOfLines = widget.numberOfAngles;
    _animationController = AnimationController(
        value: 0.0, vsync: this, duration: Duration(seconds: 10));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _animationController.reset();
    //     _animationController.forward();
    //   }
    // });
    _animationController.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  int nextInteger(int min, int max) => min + math.Random().nextInt(max - min);

  /// angle between rays
  // double angle() {
  //   final a = (math.pi / 180) * (360 / noOfLines);
  //   print(a);
  //   return a;
  // }

  @override
  Widget build(BuildContext context) {
    // final color = lineColors[nextInteger(0, lineColors.length)];
    int noOfLines = 4;
    return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          return Stack(
            children: [
              // for (int i = 0; i < noOfLines; i++)
              CustomPaint(
                child: Container(),
                painter: Raypainter(
                    angleX: 360 / noOfLines,
                    color: lineColors[5 % lineColors.length],
                    radius: 100,
                    animation: _animationController.value),
              ),
            ],
          );
        });
  }
}

class Raypainter extends CustomPainter {
  final double animation;
  final double angleX;
  final double radius;
  final int lineLength;
  final Color color;

  Raypainter({
    this.animation,
    this.angleX,
    this.color = Colors.red,
    this.radius = 200,
    this.lineLength = 50,
  });

  /// new max and new min
  double newValue(double value, double max, double min) {
    double newRange = max - min;
    double oldRange = 1.0 - 0.0;
    double transformedValue = (((value - 0.0) * newRange) / oldRange) + min;
    print(transformedValue);
    return transformedValue;
  }

  double toRadian(double angle) => angle * math.pi * 180;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint linePaint = Paint()..strokeCap = StrokeCap.round;
    linePaint..strokeWidth = 5;
    linePaint.color = Colors.red;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    final double noOflines = 360 / angleX;
    double x3, x4, y3, y4;
    Offset p3, p4;
    for (int i = 0; i < noOflines; i++) {
      double angle = angleX.toRadian() * i;
      final double animationX = animation * (centerX);
      final double animationY = animation * (centerY);
      double x1 = animationX * math.cos(angle);
      double y1 = animationY * math.sin(angle);
      double x2 = (animationX + lineLength) * math.cos(angle);
      double y2 = (animationY + lineLength) * math.sin(angle);
      Offset p1 = Offset(centerX + x1, y1 + centerY);
      Offset p2 = Offset(centerX + x2, y2 + centerY);
      linePaint.color = lineColors[i % lineColors.length];
      canvas.drawLine(p1, p2, linePaint);
      // TODO: add a line with a random gap

      double gap = 50;
      for (int j = 0; j < 10; j++) {
        gap = (j * 2 + 1) * 50.0;
        x3 = (animationX - gap) * math.cos(angle);
        y3 = (animationY - gap) * math.sin(angle);
        x4 = (animationX - (gap + lineLength)) * math.cos(angle);
        y4 = (animationY - (gap + lineLength)) * math.sin(angle);
        p3 = Offset(centerX + x3, y3 + centerY);
        p4 = Offset(centerX + x4, y4 + centerY);
        linePaint.color = lineColors[i % lineColors.length];

        canvas.drawLine(p3, p4, linePaint);
      }
    }
  }

  int loop = 0;
  void drawLine(Offset p1, Offset p2, double angle, Canvas canvas, Size size,
      Paint paint) {
    double radiusX = size.width / 2.0;
    double radiusY = size.height / 2.0;
    Paint linePaint = paint;
    final double gap = 30.0 + lineLength;
    final angleX = angle * 180 / math.pi;
    double px1 = (p1.dx - gap) * math.cos(angleX);
    double px2 = (p2.dx - gap) * math.cos(angleX);
    double py1 = (p1.dy - gap) * math.sin(angleX);
    double py2 = (p2.dy - gap) * math.sin(angleX);
    Offset p3 = Offset(px1, radiusY + py1);
    Offset p4 = Offset(px2, radiusY + py2);
    canvas.drawLine(p3, p4, linePaint);
    // while (loop < 20) {
    //   loop += 1;
    //   loop.isEven
    //       ? linePaint.color = Colors.blue
    //       : linePaint.color = Colors.red;
    //   drawLine(Offset(p3.dx, p3.dy), Offset(p4.dx, p4.dy), angle, canvas, size,
    //       linePaint);
    // }
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

extension on double {
  double toRadian() => this * math.pi / 180;
}
