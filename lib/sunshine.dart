import 'package:flutter/material.dart';

class Sunshine extends StatefulWidget {
  @override
  _SunshineState createState() => _SunshineState();
}

class _SunshineState extends State<Sunshine>
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        body: RaysBuilder());
  }
}

class RaysBuilder extends StatefulWidget {
  @override
  RaysBuilderState createState() => RaysBuilderState();
}

class RaysBuilderState extends State<RaysBuilder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: RayBuilder(
              angle: 20,
              color: Colors.red,
              length: 80,
              width: 20,
            ),
          ),
          Circle(),
        ],
      ),
    );
  }
}

class RayBuilder extends StatelessWidget {
  final double width;
  final double length;
  final Color color;
  final double angle;

  const RayBuilder({Key key, this.width, this.length, this.color, this.angle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: width,
        height: length,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
      ),
    );
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
