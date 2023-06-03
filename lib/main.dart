import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generative/art/art.dart';
import 'package:flutter_generative/art/colorsplash.dart';
import 'package:flutter_generative/art/lollipop.dart';

import 'homepage.dart';

void main() {
  runApp(MyApp());
}

Map<String, Widget> routes = {
  '/colorworks': ColorBlast(),
  "/donut": DonutsWidget(),
  '/lollipop': LolliPop(),
  '/retro': RetroArt(),
  "/ripple": RippleEffect(),
  "/spiro": GeometricSpiro(),
  '/sunshine': Sunshine(),
};

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
        for (final routeName in routes.keys)
          routeName: (context) => routes[routeName]!
      },
      home: ListWidget(),
    );
  }
}
