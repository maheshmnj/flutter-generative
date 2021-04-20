import 'package:flutter/material.dart';

import 'donut.dart';
import 'geometricspiro.dart';
import 'ripple.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  Widget _artContainerWidget({Widget child}) {
    Container(height: MediaQuery.of(context).size.height / 2, child: child);
  }

  Map<String, Widget> _list = {
    "Donut": DonutsWidget(),
    "Ripple": RippleEffect(),
    "Spiro": GeometricSpiro()
  };

  Future<void> push(BuildContext context, Widget widget) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
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
                final key = _list.keys.toList()[index];
                return ListTile(
                  title: Text('$key'),
                  onTap: () => push(context, _list[key]),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                );
              },
            )));
  }
}
