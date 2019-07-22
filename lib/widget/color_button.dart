import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  final Color border_color;
  final double border_width;

  final pressed;
  final Icon icon;

  ColorButton({
    Key key,
    this.color,
    this.width,
    this.height,
    this.border_color = Colors.white,
    this.border_width = 0.0,
    this.pressed = null,
    this.icon = null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: this.pressed,
        constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: Container(
          child: this.icon,
          margin: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 1.0, right: 1.0),
          width: this.width,
          height: this.height,
          decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(color: this.border_color, width: this.border_width)
          ),
        ),
    );
  }
}