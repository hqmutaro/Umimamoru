import 'package:flutter/material.dart';

@immutable
class OccurConeView extends StatelessWidget {

  final bloc;

  const OccurConeView({@required this.bloc}) : assert(bloc != null);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: bloc.output,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> widgets = [];
          snapshot.data.forEach((cone) => widgets.add(Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                  "・$cone",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w200
                  )
                )
              )
            )
          );
          return Column(children: widgets);
        }
        return Center(
            child: Text("離岸流は発生していません", style: TextStyle(fontSize: 20.0))
        );
      }
    );
  }
}