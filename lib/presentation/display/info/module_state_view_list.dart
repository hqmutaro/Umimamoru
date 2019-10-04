import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/module_bloc.dart';
import 'package:umimamoru/presentation/display/state/state_color.dart';
import 'package:umimamoru/presentation/display/info/module_state_view.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/presentation/ui/loader/color_loader4.dart';
import 'package:umimamoru/presentation/ui/loader/dot_type.dart';
import 'package:umimamoru/domain/module.dart';

class ModuleStateViewList extends StatelessWidget {

  final String beach;

  const ModuleStateViewList({@required this.beach}) : assert(beach != null);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ModuleBloc>(context);
    bloc.start.add(null);

     return StreamBuilder<List<Module>>(
       stream: bloc.output,
       builder: (BuildContext context, AsyncSnapshot<List<Module>> snapshot) {
         List<Widget> widgets = [];
         if (snapshot.hasData && snapshot.data.isNotEmpty) {
           snapshot.data.forEach((model) => widgets.add(ModuleStateView(module: model.id.toString(), entity: model)));
           return Column(children: widgets);
         }
         int countCone = 5;
         getCards(widgets, countCone);
         return Column(children: widgets);
       }
     );
  }

  List<Widget> getCards(List<Widget> widgets, int cones) {
    if (cones == 0) {
      return widgets;
    }
    cones--;
    widgets.add(Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          StateColor(waveLevel: "None", width: 30.0, height: 30.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 57.0, bottom: 56.0, left: 120.0),
              child: ColorLoader4(
                dotOneColor: Colors.pinkAccent,
                dotTwoColor: Colors.teal,
                dotThreeColor: Colors.indigoAccent,
                dotType: DotType.circle,
                duration: Duration(milliseconds: 1250)
              )
            )
          )
        ]
      )
    ));
    return getCards(widgets, cones);
  }
}