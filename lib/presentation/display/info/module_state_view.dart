import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/display/state/state_color.dart';
import 'package:umimamoru/domain/module_state.dart';

class ModuleStateView extends StatelessWidget {

  final String cone;
  final ModuleState entity;

  const ModuleStateView({
    @required this.cone,
    @required this.entity
  }) :
        assert(cone != null),
        assert(entity != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          StateColor(waveLevel: entity.level, width: 30.0, height: 30.0),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "${this.cone}\n" +
              "海流の速さ ${entity.speed}m/s\n" +
              "今月の離岸流発生回数: ${entity.countOccur}回\n",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w200
              )
            )
          )
        ]
      )
    );
  }
}