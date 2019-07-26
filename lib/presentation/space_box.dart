import 'package:flutter/material.dart';

class SpaceBox extends SizedBox {

  const SpaceBox({
    double width = 8.0,
    double height = 8.0
  }) : super(width: width);

  SpaceBox.width([double value = 8.0]) : super(width: value);
  SpaceBox.height([double value = 8.0]) : super(height: value);
}