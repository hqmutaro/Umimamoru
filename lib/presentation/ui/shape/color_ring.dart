import 'package:flutter/material.dart';

class ColorRing extends StatelessWidget {

  final Color color;
  final double width;
  final double height;

  const ColorRing({
    @required this.color,
    @required this.width,
    @required this.height
  }) :
      assert(color != null),
      assert(width != null),
      assert(height != null);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: null,
      constraints: BoxConstraints(minHeight: 0.0, minWidth: 0.0),
      child: Container(
        margin: const EdgeInsets.only(
          top: 3.0,
          bottom: 3.0,
          left: 3.0,
          right: 3.0
        ),
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: const BorderRadius.all(Radius.circular(25.0))
        )
      )
    );
  }
}