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
      ),
      body:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
                child: Text(
                  "qWerty1",
                  style: TextStyle(fontSize:16.0,
                      color:  Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                )
            ),

            Container(
              child:
              Image.network(
                'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
                fit:BoxFit.fill,
              ),

              padding: EdgeInsets.all(0.0),
              alignment: Alignment.center,
            )
          ]

      ),

    );
  }
}