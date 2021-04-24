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
    _animationController = AnimationController.unbounded(
      vsync: this,
    );
    startAnimation();
  }

  void startAnimation() async {
    var position = 0;
    while (mounted) {
      position++;
      _animationController.animateTo(
        position.toDouble(),
        curve: Curves.ease,
        duration: Duration(
          seconds: 1,
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  bool isNegative = false;

  int getFactor(int index) {
    int i = 0;
    int result = pow(2, i);
    while (index > result) {
      i++;
      result = pow(2, i);
    }
    return result;
  }

  double rotateAngle(int index) {
    factor = getFactor(index);
    if (index % 2 != 0) {
      isNegative = !isNegative;
      int angle = 8 * getFactor(index);
      if (isNegative) {
        return -_animationController.value * 2 * pi / angle;
      } else {
        return _animationController.value * 2 * pi / angle;
      }
    } else {
      return 0;
    }
  }

  List<Color> lineColors = [
    Colors.blue[100],
    Colors.green[100],
    Colors.pink[100],
    Colors.white,
    Colors.orange[100],
    Colors.purple[100],
    Colors.red[100],
  ];

  Color getColor(int index) {
    // int index = Random().nextInt(lineColors.length%);
    return lineColors[index % lineColors.length];
  }

  int linesCount = 8;
  int factor = 1;
  bool toggle = false;
  int power = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            for (int i = 1; i < 20; i++)
              AnimatedBuilder(
                animation: _animationController,
                builder: (_, Widget child) => RetroWheel(
                  lines: getFactor(i) * 8,
                  innerRadius: i != 1 ? 40.0 * (i - 1) : 20,
                  outerRadius: 40.0 * (i),
                  angle: rotateAngle(i),
                  color: getColor(i),
                ),
              )
          ],
        ));
  }
}

class RetroWheel extends StatefulWidget {
  final int lines;
  final double innerRadius;
  final double outerRadius;
  final double angle;
  final Color color;

  const RetroWheel(
      {Key key,
      this.lines,
      this.innerRadius,
      this.outerRadius,
      this.angle,
      this.color})
      : super(key: key);
  @override
  _RetroWheelState createState() => _RetroWheelState();
}

class _RetroWheelState extends State<RetroWheel> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.angle != 0
          ? Transform.rotate(
              angle: widget.angle,
              child: CustomPaint(
                painter: RetroPainter(widget.innerRadius, widget.outerRadius,
                    widget.lines, widget.color),
              ),
            )
          : CustomPaint(
              painter: RetroPainter(widget.innerRadius, widget.outerRadius,
                  widget.lines, widget.color),
            ),
    );
  }
}

class RetroPainter extends CustomPainter {
  final double innerRadius;
  final double outerRadius;
  final int noOfLines;
  final Color color;

  RetroPainter(this.innerRadius, this.outerRadius, this.noOfLines, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;

    // double centerX = size.width / 2.0;
    // double centerY = size.height / 2.0;
    // Offset center = Offset(centerX, centerY);
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
