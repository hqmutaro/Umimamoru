import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/info/cone_state_view.dart';
import 'package:umimamoru_flutter/domain/entity.dart';
import 'package:umimamoru_flutter/presentation/loader/color_loader4.dart';
import 'package:umimamoru_flutter/presentation/loader/dot_type.dart';
import 'package:umimamoru_flutter/presentation/info/state/state_color.dart';

class ConeStateViewList extends StatelessWidget {

  Map<String, Entity> entities;

  ConeStateViewList({@required this.entities}) : assert(entities != null);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (this.entities.isEmpty) {
      int countCone = 5;
      getCards(widgets, countCone);
      return Column(children: widgets);
    }

    this.entities.forEach((cone, entity) => widgets.add(ConeStateView(cone: cone, entity: entity)));

    return Column(children: widgets);
  }

  List<Widget> getCards(List<Widget> widgets, int cones) {
    if (cones == 0) {
      return widgets;
    }
    cones--;
    widgets.add(Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: Row(
          children: <Widget>[
            StateColor(waveLevel: "null", width: 30.0, height: 30.0),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 57.0, bottom: 56.0, left: 120.0),
                child: ColorLoader4(
                  dotOneColor: Colors.pink,
                  dotTwoColor: Colors.teal,
                  dotThreeColor: Colors.indigoAccent,
                  dotType: DotType.circle,
                  duration: Duration(milliseconds: 1250),
                ),
              ),
            )
          ]
        ),
      )
    );
    return getCards(widgets, cones);
  }
}