import 'dart:math';
import 'package:flutter/material.dart';

class RainDrops extends StatefulWidget {
  static final route = '/rain';
  const RainDrops({Key? key}) : super(key: key);

  @override
  State<RainDrops> createState() => _RainDropsState();
}

class _RainDropsState extends State<RainDrops>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    initializeDrops();
    _addListeners();
    controller.repeat();
  }

  void _addListeners() {
    controller.addListener(() {});

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
  }

  List<Drop> initializeDrops() {
    final random = Random();

    for (int i = 0; i < 100; i++) {
      final startX = random.nextDouble() * 400;
      final startY = random.nextDouble() * 100;
      final endX = startX;
      final endY = startY + 800;
      final speed = random.nextInt(10) + 1; // Ensure speed is not zero
      final duration = Duration(seconds: 5);

      final animation = Tween<Offset>(
        begin: Offset(startX, startY),
        end: Offset(endX, endY),
      ).animate(controller);

      final drop = Drop(
        speed: speed,
        duration: duration,
        start: Offset(startX, startY),
        end: Offset(endX, endY),
        controller: controller,
        animation: animation,
      );

      drops.add(drop);
    }

    return drops;
  }

  List<Drop> drops = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SizedBox.expand(
          child: CustomPaint(
            painter: WaterDropsPainter(drops),
          ),
        );
      },
    );
  }
}

class WaterDropsPainter extends CustomPainter {
  List<Drop> drops;

  WaterDropsPainter(this.drops);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (int i = 0; i < drops.length; i++) {
      final drop = drops[i];
      if (drop.animation != null) {
        final offset = drop.animation!.value;

        final p1 = Offset(offset.dx, offset.dy);
        final p2 = Offset(
            offset.dx, offset.dy + 10.0); // Adjust the length of raindrops
        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Drop {
  Offset? start;
  final Offset? end;
  final int? speed;
  final Animation<Offset>? animation;
  final Duration? duration;
  final AnimationController? controller;
  bool isAnimating;
  Drop(
      {this.speed,
      required this.duration,
      this.animation,
      this.controller,
      this.end,
      this.isAnimating = false,
      this.start});

  void update() {
    start = start! + start! * speed!.toDouble();
    if (start!.dx > end!.dx || start!.dy > end!.dy) {
      start = end;
      isAnimating = false;
    }
    isAnimating = true;
  }
}
