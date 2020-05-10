import 'package:flutter/material.dart';
import 'package:flutter_generative/donut.dart';
import 'package:flutter_generative/geometricspiro.dart';
import 'package:flutter_generative/ripple.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  Widget _artContainerWidget({Widget child}) {
    Container(height: MediaQuery.of(context).size.height / 2, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                child: DonutsWidget()),
            Container(
                height: MediaQuery.of(context).size.height,
                child: RippleEffect()),
            Container(
                height: MediaQuery.of(context).size.height,
                child: GeometricSpiro()),
          ],
        ),
      ),
    );
  }
}
