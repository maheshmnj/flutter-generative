import 'dart:math';

import 'package:flutter/material.dart';

class Fireworks extends StatefulWidget {
  const Fireworks({Key key}) : super(key: key);

  @override
  State<Fireworks> createState() => _FireworksState();
}

class _FireworksState extends State<Fireworks>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    controller.repeat();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Particle> _particles = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        print('tapped');
        for (int i = 0; i < 100; i++) {
          _particles.add(Particle(
              details.localPosition.dx,
              details.localPosition.dy,
              (Random().nextDouble() - 0.5) * 10,
              (Random().nextDouble() - 0.5) * 10,
              2,
              Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0)));
        }
      },
      child: CustomPaint(
        painter: FireWorksPainter(
          particles: _particles,
        ),
        child: Container(),
      ),
    );
  }
}

class Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  Color color;
  Particle(this.x, this.y, this.vx, this.vy, this.radius, this.color);
}

class FireWorksPainter extends CustomPainter {
  List<Particle> particles;
  FireWorksPainter({this.particles});

  // burst with delay
  void burst(Canvas canvas, Size size) {
    for (int i = 0; i < particles.length; i++) {
      canvas.drawCircle(Offset(particles[i].x, particles[i].y),
          particles[i].radius, Paint()..color = particles[i].color);
      particles[i].x += particles[i].vx;
      particles[i].y += particles[i].vy;
      particles[i].vy += 0.1;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    burst(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
