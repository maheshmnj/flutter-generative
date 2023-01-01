import 'package:flutter/material.dart';
import 'package:flutter_generative/art/art.dart';
import 'package:flutter_generative/art/fireworks.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
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
                  onTap: () => push(
                      context,
                      ArtView(
                        artKey: key,
                      )),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                );
              },
            )));
  }
}

Map<String, Widget> _list = {
  "Donut": DonutsWidget(),
  "Ripple": RippleEffect(),
  "Spiro": GeometricSpiro(),
  'Retro': RetroArt(),
  'Sunshine': Sunshine(),
  'FireWorks': Fireworks(),
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
