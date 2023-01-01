import 'package:flutter/material.dart';
import 'package:flutter_generative/art/art.dart';
import 'package:flutter_generative/art/fireworks.dart';
import 'package:flutter_generative/extensions.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  Future<void> push(BuildContext context, String routeName) async {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = _list.length + 1;
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              itemCount: _list.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                if (index == itemCount - 1) {
                  return Divider(height: 1);
                }
                final routeName = _list.keys.elementAt(index);
                return ListTile(
                  title: Text(routeToTitle(routeName)!,
                      style: TextStyle(fontSize: 20)),
                  onTap: () => push(context, routeName),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                );
              },
            )));
  }
}

String? routeToTitle(String routeName) {
  return routeName.substring(1).capitalize();
}

Map<String, Widget> _list = {
  "/donut": DonutsWidget(),
  "/ripple": RippleEffect(),
  "/spiro": GeometricSpiro(),
  '/retro': RetroArt(),
  '/sunshine': Sunshine(),
  '/fireworks': Fireworks(),
};

class ArtView extends StatelessWidget {
  final String artKey;

  const ArtView({Key? key, required this.artKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _list[artKey]!,
          Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.close, size: 32, color: Colors.grey),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
        ],
      ),
    );
  }
}
