import 'package:flutter/material.dart';

@immutable
class OccurCone extends StatelessWidget {

  final List<String> cone;

  const OccurCone({@required this.cone}) : assert(cone != null);

  @override
  Widget build(BuildContext context) {
    List<Padding> widgets = [];

    this.cone.forEach((cone) => widgets.add(Padding(
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
    return Column(children: widgets);
  }
}