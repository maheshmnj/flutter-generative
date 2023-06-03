import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _LolliPopPainter extends CustomPainter {
  double size;
  _LolliPopPainter(this.size);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 3);
    double candySize = this.size;
    stick(canvas, size, Offset(center.dx, center.dy + candySize / 1),
        length: candySize);
    paintLolliPop(canvas, size, center, radius: candySize);
  }

  // draw lollipop stick
  void stick(Canvas canvas, Size size, Offset offset, {double length = 100.0}) {
    double width = length / 30;
    final stickPaint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(offset.dx, offset.dy),
                width: width,
                height: length),
            Radius.circular(4.0)),
        stickPaint);
  }

  void spiralLollipop(Canvas canvas, Size size, Offset offset,
      {double radius = 100.0}) {
    // draw a spiral from the center
    final spiralPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final spiralPath = Path();
    spiralPath.moveTo(offset.dx, offset.dy);
    double angle = 0;
    double spiralRadius = radius;
    double spiralRadiusIncrement = 0.01;
    // double spiralWidth = 0.5;
    // double spiralWidthIncrement = 0.05;
    List<Pair> layers = [];
    while (angle < 12 * pi) {
      // spiralPaint.strokeWidth = spiralWidth;
      spiralRadius += spiralRadiusIncrement;
      final spiralPoint = Offset(
          offset.dx + spiralRadius * cos(angle),
          offset.dy +
              spiralRadius * sin(angle) +
              spiralRadiusIncrement * angle / (2 * pi));
      spiralPath.lineTo(spiralPoint.dx, spiralPoint.dy);
      angle += 0.1;
      layers.add(Pair(spiralPath, spiralPaint));
    }
    for (int i = layers.length - 1; i >= 0; i--) {
      canvas.drawPath(layers[i].path, layers[i].paint);
    }
  }

  void paintLolliPop(Canvas canvas, Size size, Offset offset,
      {double radius = 100.0}) {
    int arcs = 8;
    final edgePaint = Paint()
      ..color = Colors.black26
      ..blendMode = BlendMode.colorDodge
      ..style = PaintingStyle.stroke;
    // add shadow
    edgePaint.maskFilter = MaskFilter.blur(BlurStyle.outer, 4);

    final lollipopPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    double startAngle = 0;
    Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, radius / 2, backgroundPaint);
    for (int i = 0; i < arcs; i++) {
      final sweepAngle = (360 / (2 * arcs)) * (pi / 180);
      canvas.drawCircle(offset + Offset(2, 5), radius / 2, edgePaint);
      canvas.drawArc(
          Rect.fromCenter(center: offset, width: radius, height: radius),
          startAngle,
          sweepAngle,
          true,
          lollipopPaint);
      startAngle = startAngle + 2 * sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class LolliPop extends StatefulWidget {
  const LolliPop({super.key});

  @override
  State<LolliPop> createState() => _LolliPopState();
}

class _LolliPopState extends State<LolliPop> {
  double size = 100.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.blue.shade100,
        ),
        Align(
            alignment: Alignment.center,
            child: CustomPaint(
              painter: _LolliPopPainter(
                  size), // Replace with your own custom painter
            )),
        Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: CupertinoSlider(
                value: size,
                min: 0,
                max: 800,
                onChanged: (value) {
                  size = value;
                  setState(() {});
                },
              ),
            )),
      ],
    );
  }
}

class Pair {
  Path path;
  Paint paint;
  Pair(this.path, this.paint);
}
