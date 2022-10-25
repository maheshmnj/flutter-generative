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
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    generateParticels();
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Particle> _particles = [];

  void generateParticels() {
    final random = Random();
    final dx = random.nextDouble() * size.width - 100;
    final dy = random.nextDouble() * size.height - 100;
    Future.delayed(Duration(milliseconds: 1500), () {
      _particles.clear();
      for (int i = 0; i < 200; i++) {
        final angle = Random().nextDouble() * 2 * pi;
        final speed = Random().nextDouble() * 8;
        _particles.add(Particle(dx, dy, cos(angle) * speed, -sin(angle) * speed,
            2, Colors.accents[Random().nextInt(Colors.accents.length)]));
      }
      generateParticels();
    });
  }

  Size size = Size.zero;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: FireWorksPainter(
            particles: _particles,
          ),
          child: Container(),
        );
      },
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
