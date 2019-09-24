import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';
import 'package:umimamoru/presentation/ui/shape/color_ring.dart';

@immutable
class Header extends StatelessWidget {

  final String title;

  const Header({@required this.title}) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ColorRing(
            color: UmimamoruTheme.colorTheme,
            height: 20.0,
            width: 20.0,
        ),
        Text(
            this.title,
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w200,
            )
        )
      ],
    );
  }
}