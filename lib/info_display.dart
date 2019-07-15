import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class InfoDisplay extends StatefulWidget {
  String _region;

  InfoDisplay(this._region);

  @override
  _InfoDisplay createState() => _InfoDisplay();
}

class _InfoDisplay extends State<InfoDisplay> {
  List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = <Widget>[];
    contents.add(Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "沖縄県名護市辺野古豊原\n${widget._region}ビーチのようす",
        style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w200,
            fontFamily: "Roboto"),
      ),
    ));
    contents.add(Image.network(
      'https://avatars1.githubusercontent.com/u/39296516?s=460&v=4',
      fit: BoxFit.fill,
      width: 100.0,
      height: 100.0,
    ));
    for (int i = 0; i < _colors.length; i++) {
      Color c = _colors[i];
      contents.add(ColorButton(color: c,));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._region),
          backgroundColor: Colors.green[400],
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
                children: contents
          ),
        ),
      )
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  ColorButton({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new RawMaterialButton(
        onPressed: null,
        constraints: BoxConstraints(minWidth: 60.0, minHeight: 50.0),
        child: Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(color: Colors.white, width: 0.0)
          ),
        )
    );
  }
}