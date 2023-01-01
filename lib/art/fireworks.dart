import 'dart:math';

import 'package:flutter/material.dart';

class Fireworks extends StatefulWidget {
  const Fireworks({Key? key}) : super(key: key);

  @override
  State<Fireworks> createState() => _FireworksState();
}

class _FireworksState extends State<Fireworks> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.6, curve: GravityCurve()));
    animation2 = CurvedAnimation(
        parent: controller, curve: Interval(0.6, 1.0, curve: GravityCurve()));
    generateParticles(isRecursive: true);
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Particle> _particles = [];
  List<Particle> _particles2 = [];

  List<Color> fireColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];
  void generateParticles({bool isRecursive = false, double? x, double? y}) {
    final random = Random();
    final dx = x ?? random.nextDouble() * size.width / 2;
    final dx2 = x ?? random.nextDouble() * size.width / 2;
    final dy = y ?? random.nextDouble() * size.height / 2;
    final dy2 = y ?? random.nextDouble() * size.height / 2;
    Future.delayed(Duration(milliseconds: 1500), () async {
      _particles.clear();
      _particles2.clear();
      for (int i = 0; i < 200; i++) {
        final angle = Random().nextDouble() * 2 * pi;
        final speed = Random().nextDouble() * 8;
        final radius = Random().nextDouble() * 10;
        _particles.add(Particle(dx, dy, cos(angle) * speed, -sin(angle) * speed,
            radius, fireColors[Random().nextInt(fireColors.length)]));
      }
      await Future.delayed(Duration(milliseconds: Random().nextInt(5000)));
      for (int i = 0; i < 200; i++) {
        final angle2 = Random().nextDouble() * 2 * pi;
        final speed2 = Random().nextDouble() * 8;
        final radius2 = Random().nextDouble() * 10;
        _particles2.add(Particle(
            dx2,
            dy2,
            cos(angle2) * speed2,
            -sin(angle2) * speed2,
            radius2,
            fireColors[Random().nextInt(fireColors.length)]));
      }
      if (isRecursive) {
        generateParticles(isRecursive: true);
      }
    });
  }

  Size size = Size.zero;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onPanDown: (details) {
            final x = details.localPosition.dx;
            final y = details.localPosition.dy;
            generateParticles(isRecursive: false, x: x, y: y);
          },
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                painter: FireWorksPainter(
                  particles: _particles,
                ),
                child: Center(
                  child: Text(
                    'Happy Diwali',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                ),
              );
            },
          ),
        ),
        AnimatedBuilder(
          animation: animation2,
          builder: (context, child) {
            return CustomPaint(
                painter: FireWorksPainter(
                  particles: _particles2,
                ),
                child: Container());
          },
        ),
      ],
    );
  }
}

class GravityCurve extends Curve {
  @override
  double transformInternal(double t) {
    return sin((pi / 4) * t);
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
  FireWorksPainter({required this.particles});

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
