import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/widget/color_button.dart';
import 'package:umimamoru_flutter/widget/space_box.dart';
import 'package:umimamoru_flutter/presentation/info/main.dart' as info;

class InfoDisplayState extends State<info.InfoDisplay> {
  Map<String, Color> _colors = {
    "calm" : Colors.blue,
    "ordinarily" : Color(0xFF92D050),
    "fast" : Color(0xFFEF8468)
  };

  List<String> occur_cone = <String>[];
  Map test_data = {};

  updateTestData(Map updated_test_data) {
    setState(() {
      this.test_data = updated_test_data;
    });
  }

  updateOccurCone(List<String> updated_occur_cone) {
    setState(() {
      this.occur_cone = updated_occur_cone;
    });
  }

  @override
  void initState() {
    this.test_data = {
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
    this.occur_cone = [
      "4番コーン",
      "5番コーン"
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = <Widget>[];
    contents.add(Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: Color(0xFF66BAB7),
                child: Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(width: 20),
            Text(
              "別のビーチに変更する",
              style: TextStyle(
                fontSize: 20.0
              )
            )
          ],
        )
      )
    );
    contents.add(Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "${widget.region}\n" +
              "${widget.beach}の波のようす",
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        )
    ));
    contents.add(
      Container(
        child: Image.asset(
          'images/rigan_bar.png',
          fit:BoxFit.fitWidth,
        ),
        alignment: Alignment.center,
      ),
    );
    contents.add(
        Row(
          children: <Widget>[
            ColorButton(
                color: Color(0xFF4DBBB4),
                width: 20.0,
                height: 20.0,
                border_color: Colors.white,
                border_width: 30.0
            ),
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
            ColorButton(
                color: Color(0xFF4DBBB4),
                width: 20.0,
                height: 20.0,
                border_color: Colors.white,
                border_width: 30.0
            ),
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
              ColorButton(color: Color(0xFFEF8468), width: 15.0, height: 15.0),
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
              ColorButton(color: Color(0xFF92D050), width: 15.0, height: 15.0),
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
            widget.beach,
            style: TextStyle(
                color: Colors.white
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF4CBBB4),
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