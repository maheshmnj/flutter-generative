import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generative/art/art.dart';
import 'package:flutter_generative/art/raindrops.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'homepage.dart';

Future<void> main() async {
  usePathUrlStrategy();

  runApp(MyApp());
}

Map<String, Widget> routes = {
  '/colorworks': ColorBlast(),
  "/donut": DonutsWidget(),
  '/lollipop': LolliPop(),
  '/retro': RetroArt(),
  "/ripple": RippleEffect(),
  "/spiro": GeometricSpiro(),
  RainAnimation.route: RainAnimation(),
  Sunshine.routeName: Sunshine(),
  GradientArt.routeName: GradientArt(),
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
