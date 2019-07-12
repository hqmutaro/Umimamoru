import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoDisplay extends StatefulWidget {
  String _region;

  InfoDisplay(this._region);

  @override
  _InfoDisplay createState() => _InfoDisplay();
}

class _InfoDisplay extends State<InfoDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._region),
        backgroundColor: Colors.green[400],
      ),
      body:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 13.0, 24.0, 24.0),
            ),

            Text("testtest"),

            Image.asset(
              'img/teapot.png',
              fit:BoxFit.fitWidth,
              width: 130.0,
              height: 130.0,
            ),

            Container(
              child:
              Text(
                "発生中",
                style: TextStyle(fontSize:20.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"),
              ),

              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
            )
          ]

      ),

    );
  }
}