import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/info/state/state_color.dart';
import 'package:umimamoru_flutter/application/repository/cone_state_repository.dart';
import 'package:umimamoru_flutter/domain/cone_state.dart';

@immutable
class ConeStateView extends StatelessWidget {

  String cone;
  ConeState entity;

  ConeStateView({@required this.cone, @required this.entity}) : assert(cone != null), assert(entity != null);

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
                  "波の速さ ${entity.speed}m/s\n" +
                  "今月の離岸流発生回数: ${entity.count_occur}回\n",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"),
            ),
          )
        ],
      ),
    );
  }
}