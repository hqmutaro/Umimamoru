import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/info/ring.dart';

@immutable
class Header extends StatelessWidget {

  final String title;

  const Header({@required this.title}) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Ring(color: Color(0xFF4DBBB4),
            width: 20.0,
            height: 20.0
        ),
        Text("離岸流が発生している場所",
            style: TextStyle(
                fontSize: 25.0,
                color: Color(0xFF000000),
                fontWeight: FontWeight.w200,
                fontFamily: "Roboto"
            )
        )
      ],
    );
  }
}