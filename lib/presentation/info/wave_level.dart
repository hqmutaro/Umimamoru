import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/space_box.dart';
import 'package:umimamoru_flutter/presentation/info/ring.dart';

@immutable
class WaveLevel extends StatelessWidget {

  const WaveLevel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          SpaceBox.width(13),
          Text("波の速さ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF000000),
                  fontFamily: "Roboto"
              )
          ),
          SpaceBox.width(10),
          Ring(color: Color(0xFFEF8468), width: 15.0, height: 15.0),
          Text("速い",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF000000),
                  fontFamily: "Roboto"
              )
          ),
          SpaceBox.width(7),
          Ring(color: Color(0xFF92D050), width: 15.0, height: 15.0),
          Text("普通",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF000000),
                  fontFamily: "Roboto"
              )
          ),
          SpaceBox.width(7),
          Ring(color: Colors.blue, width: 15.0, height: 15.0),
          Text("穏やか",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF000000),
                  fontFamily: "Roboto"
              )
          ),
        ],
      ),
    );
  }
}