import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/config/dev_board.dart';
import 'package:umimamoru/presentation/config/watching_view.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';
import 'package:umimamoru/presentation/ui/button/previous_button.dart';

class Config extends StatefulWidget {

  const Config({Key key}) : super(key: key);

  @override
  _Config createState() => _Config();
}

class _Config extends State<Config> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: UmimamoruTheme.colorTheme,
        title: Text("設定", style: TextStyle(color: Colors.white))
      ),
      body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PreviousButton(message: "ホームに戻る"),
                    Card(
                      child: ListTile(
                          leading: Icon(Icons.remove_red_eye, color: Colors.pinkAccent),
                          title: Text(
                              "監視リスト",
                              style: TextStyle(
                                  fontSize: 25.0
                              )
                          ),
                          onTap: onWatching()
                      )
                    ),
                    Card(
                        child: ListTile(
                            leading: Icon(Icons.developer_board, color: Colors.pinkAccent),
                            title: Text(
                                "開発",
                                style: TextStyle(
                                    fontSize: 25.0
                                )
                            ),
                            onTap: onDevBoard()
                        )
                    )
                  ]
              )
          )
      )
    );
  }

  Function onWatching() {
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WatchingView()));
    };
  }

  Function onDevBoard() {
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DevBoard()));
    };
  }
}