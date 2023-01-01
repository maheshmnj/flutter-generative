import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generative/art/art.dart';
import 'package:flutter_generative/art/fireworks.dart';

import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Generative',
      debugShowCheckedModeBanner: !kDebugMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => ListWidget(),
        '/sunshine': (context) => Sunshine(),
        '/fireworks': (context) => Fireworks(),
        '/ripple': (context) => RippleEffect()
      },
      // home: ListWidget(),
    );
  }
}
