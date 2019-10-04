import 'package:flutter/material.dart';

class StateColor extends StatelessWidget {

  static const Map<String, Color> _colors = {
    "Calm" : Colors.blue,
    "Ordinarily" : Color(0xFF92D050),
    "Fast" : Color(0xFFEF8468),
    "None" : Colors.deepPurpleAccent
  };

  final String waveLevel;
  final double width;
  final double height;

  const StateColor({
    @required this.waveLevel,
    this.width = 30.0,
    this.height = 30.0
  }) : assert(waveLevel != null);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: null,
      constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      child: Container(
        margin: const EdgeInsets.only(
            top: 3.0,
            bottom: 3.0,
            left: 1.0,
            right: 1.0
        ),
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
            color: _colors[this.waveLevel],
            borderRadius: BorderRadius.all(Radius.circular(25.0))
        )
      )
    );
  }
}