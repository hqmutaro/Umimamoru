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
  Map<String, Color> _colors = {
    "calm" : Colors.blue,
    "ordinarily" : Colors.green,
    "fast" : Colors.red
  };

  @override
  Widget build(BuildContext context) {
    var contents = <Widget>[];
    var test_data = {
      "1番コーン" : {
        "state" : "calm",
        "wave.speed" : 3,
        "count.occur" : 2
      },
      "2番コーン" : {
        "state" : "ordinarily",
        "wave.speed" : 4,
        "count.occur" : 3
      },
      "3番コーン" : {
        "state" : "ordinarily",
        "wave.speed" : 5,
        "count.occur" : 4
      },
      "4番コーン" : {
        "state" : "fast",
        "wave.speed" : 6,
        "count.occur" : 5
      },
      "5番コーン" : {
        "state" : "fast",
        "wave.speed" : 7,
        "count.occur" : 5
      },
    };
    var occur_cone = [
      "4番コーン",
      "5番コーン"
    ];

    contents.add(Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "沖縄県名護市辺野古豊原\n${widget._region}ビーチの波のようす",
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
    contents.add(
        Row(
          children: <Widget>[
            ColorButton(color: Colors.lightGreen, width: 20.0, height: 20.0, border_color: Colors.white, border_width: 30.0),
            Text(
                "離岸流が発生している場所",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"
                )
            )
          ],
        )
    );
    occur_cone.forEach((cone) => contents.add(
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
              "・${cone}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"
              )
          ),
        )
    )
    );
    contents.add(
        Row(
          children: <Widget>[
            ColorButton(color: Colors.lightGreen, width: 20.0, height: 20.0, border_color: Colors.white, border_width: 30.0),
            Text(
                "波のようす",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"
                )
            )
          ],
        )
    );
    contents.add(
        Center(
          child: Row(
            children: <Widget>[
              SpaceBox.width(13),
              Text(
                  "波の速さ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF000000),
                      fontFamily: "Roboto"
                  )
              ),
              SpaceBox.width(10),
              ColorButton(color: Colors.red, width: 15.0, height: 15.0),
              Text(
                  "速い",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF000000),
                      fontFamily: "Roboto"
                  )
              ),
              SpaceBox.width(7),
              ColorButton(color: Colors.green, width: 15.0, height: 15.0),
              Text(
                  "普通",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF000000),
                      fontFamily: "Roboto"
                  )
              ),
              SpaceBox.width(7),
              ColorButton(color: Colors.blue, width: 15.0, height: 15.0),
              Text(
                  "穏やか",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF000000),
                      fontFamily: "Roboto"
                  )
              ),
            ],
          ),
        )
    );
    test_data.forEach((cone, status) => contents.add(
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 4.0,
          margin: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              ColorButton(color: _colors[status["state"]], width: 30.0, height: 30.0,),
              Padding(
                padding: EdgeInsets.all(5.0),
                  child: Text(
                    "${cone}\n" +
                        "波の速さ ${status["wave.speed"]}m/s\n" +
                        "今月の離岸流発生回数: ${status["count.occur"]}回\n",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),
              )
            ],
          ),
        )
    ));
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget._region,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.navigate_before),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.green[400],
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contents
            ),
          ),
        )
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  final Color border_color;
  final double border_width;

  ColorButton({Key key, this.color, this.width, this.height, this.border_color = Colors.white, this.border_width = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new RawMaterialButton(
        onPressed: null,
        constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: Container(
          margin: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 1.0, right: 1.0),
          width: this.width,
          height: this.height,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(color: this.border_color, width: this.border_width)
          ),
        )
    );
  }
}

class SpaceBox extends SizedBox {
  SpaceBox({double width = 8, double height = 8}) : super(width: width, height: height);

  SpaceBox.width([double value = 8]) : super(width: value);
  SpaceBox.height([double value = 8]) : super(height: value);
}
