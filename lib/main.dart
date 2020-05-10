import 'package:flutter/material.dart';
import 'package:flutter_generative/donut.dart';
import 'package:flutter_generative/geometricspiro.dart';
import 'package:flutter_generative/homepage.dart';
import 'package:flutter_generative/ripple.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Generative',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListWidget(
      ),
    );
  }
}
