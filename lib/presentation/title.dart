import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/selector/main.dart';
import 'package:umimamoru_flutter/presentation/config/main.dart';
import 'package:umimamoru_flutter/presentation/simple_round_icon_button.dart';

class Title extends StatefulWidget {
  Title({Key key}) : super(key: key);
  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<Title> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Umimamoru",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: Center(
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 50.0),
              ),
              Text(
                "うみまもる",
                style: TextStyle(
                    fontSize:60.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontFamily: "Roboto"),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
              ),
              SimpleRoundIconButton(
                backgroundColor: Colors.lightBlue,
                buttonText: "地域を選択する",
                textColor: Colors.white,
                textSize: 20.0,
                icon: Icon(Icons.arrow_forward),
                iconColor: Colors.lightBlue,
                iconAlignment: Alignment.centerRight,
                onPressed: onSelectRegionButton(),
              ),
              SimpleRoundIconButton(
                backgroundColor: Colors.deepPurple,
                buttonText: "設定",
                textColor: Colors.white,
                textSize: 20.0,
                icon: Icon(Icons.settings),
                iconColor: Colors.blueGrey,
                iconAlignment: Alignment.centerRight,
                onPressed: onConfigButton(),
              ),
            ]
        ),
      )
    );
  }

  Function onConfigButton() {
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigDisplay()));
    };
  }

  Function onSelectRegionButton(){
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchList()));
    };
  }
}