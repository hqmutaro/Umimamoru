import 'package:flutter/material.dart';

class Ring extends StatelessWidget {

  final Color color;
  final double width;
  final double height;

  Ring({
    Key key,
    @required this.color,
    @required this.width,
    @required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: null,
        constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: Container(
          margin: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 1.0, right: 1.0),
          width: this.width,
          height: this.height,
          decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
    );
  }
}