import 'package:flutter/material.dart';
import 'package:flutter_generative/extensions.dart';
import 'package:flutter_generative/main.dart';

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
    int itemCount = routes.length + 1;
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              itemCount: routes.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                if (index == itemCount - 1) {
                  return Divider(height: 1);
                }
                final routeName = routes.keys.elementAt(index);
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
