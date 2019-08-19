import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';
import 'package:umimamoru/presentation/ui/button/simple_round_icon_button.dart';
import 'package:umimamoru/presentation/beach/main.dart';
import 'package:umimamoru/presentation/config/main.dart';

// First page.
class Home extends StatefulWidget {

  const Home({Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UmimamoruTheme.colorTheme,
        title: Text(
          "Umimamoru",
          style: TextStyle(color: Colors.white)
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Text(
                "うみまもる",
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w100,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SimpleRoundIconButton(
                backgroundColor: Colors.lightBlue,
                buttonText: "地域を選択する",
                textColor: Colors.white,
                textSize: 20.0,
                icon: Icon(Icons.arrow_forward),
                iconColor: Colors.lightBlue,
                iconAlignment: Alignment.centerRight,
                onPressed: onBeachButton()
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SimpleRoundIconButton(
                backgroundColor: Colors.deepPurple,
                buttonText: "設定",
                textColor: Colors.white,
                textSize: 20.0,
                icon: Icon(Icons.settings),
                iconColor: Colors.blueGrey,
                iconAlignment: Alignment.centerRight,
                onPressed: onConfigButton()
              )
            )
          ]
        )
      )
    );
  }

  Function onConfigButton() {
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Config()));
    };
  }

  Function onBeachButton(){
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Beach()));
    };
  }
}