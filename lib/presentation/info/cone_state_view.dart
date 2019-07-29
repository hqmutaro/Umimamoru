import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/info/state/state_color.dart';

@immutable
class ConeStateView extends StatelessWidget {

  Map state;

  ConeStateView({@required this.state}) : assert(state != null);

  @override
  Widget build(BuildContext context) {
    List<Card> widgets = [];

    this.state.forEach((cone, status) => widgets.add(Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          StateColor(waveLevel: status["state"], width: 30.0, height: 30.0),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "${cone}\n" +
                  "波の速さ ${status["wave.speed"]}m/s\n" +
                  "今月の離岸流発生回数: ${status["count.occur"]}回\n",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"),
            ),
          )
        ],
      ),
    )
    )
    );
    return Column(children: widgets);
  }
}