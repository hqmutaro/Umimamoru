import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/occur_module_bloc.dart';

@immutable
class OccurPoleView extends StatelessWidget {

  final String beach;

  const OccurPoleView({@required this.beach}) : assert(beach != null);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OccurModuleBloc>(context);
    bloc.start.add(null);

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