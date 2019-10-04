import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/ui/box/space_box.dart';
import 'package:umimamoru/presentation/ui/shape/color_ring.dart';

@immutable
class WaveLevelBar extends StatelessWidget {

  const WaveLevelBar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          SpaceBox.width(13),
          Text(
              "海流の速さ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0
              )
          ),
          SpaceBox.width(10),
          ColorRing(color: Color(0xFFEF8468), width: 15.0, height: 15.0),
          Text(
              "速い",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0
              )
          ),
          SpaceBox.width(7),
          ColorRing(color: Color(0xFF92D050), width: 15.0, height: 15.0),
          Text(
              "普通",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0
              )
          ),
          SpaceBox.width(7),
          ColorRing(color: Colors.blue, width: 15.0, height: 15.0),
          Text(
              "穏やか",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0
              )
          )
        ]
      )
    );
  }
}