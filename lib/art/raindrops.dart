import 'dart:math';

import 'package:flutter/material.dart';

class Raindrop {
  double x;
  double y;
  double size;
  double speed;

  Raindrop(this.x, this.y, this.size, this.speed);
}

class RainAnimation extends StatefulWidget {
  static final route = '/rain';
  const RainAnimation({Key? key}) : super(key: key);
  @override
  _RainAnimationState createState() => _RainAnimationState();
}

class _RainAnimationState extends State<RainAnimation>
    with TickerProviderStateMixin {
  List<Raindrop> raindrops = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    );

    _controller.repeat();

    _controller.addListener(() {
      updateRaindrops(_controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: RainPainter(raindrops),
            child: Container(),
          );
        });
  }

  void updateRaindrops(double time) {
    setState(() {
      raindrops.removeWhere((drop) =>
          drop.y > MediaQuery.of(context).size.height ||
          (drop.y > 0 && drop.y < 10 && time < 0.1));

      for (int i = 0; i < 5; i++) {
        double initialX =
            Random().nextDouble() * MediaQuery.of(context).size.width;
        double initialY = 0.0;
        double size = Random().nextDouble() * 5.0 + 5.0;
        double speed = Random().nextDouble() * 20.0 + 20.0;

        raindrops.add(Raindrop(initialX, initialY, size, speed));
      }

      raindrops.forEach((drop) {
        double gravity = 3.0;
        double displacement = 0.5 * gravity * time * time;
        drop.y += drop.speed * time + displacement;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RainPainter extends CustomPainter {
  final List<Raindrop> raindrops;

  RainPainter(this.raindrops);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    raindrops.forEach((drop) {
      canvas.drawLine(
        Offset(drop.x, drop.y),
        Offset(drop.x, drop.y + drop.size),
        paint,
      );
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
