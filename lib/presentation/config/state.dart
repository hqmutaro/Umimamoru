import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/config/main.dart';

class ConfigState extends State<ConfigDisplay> {

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = <Widget>[];
    contents.add(Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: Color(0xFF66BAB7),
                child: Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(width: 20),
            Text(
                "ホームに戻る",
                style: TextStyle(
                    fontSize: 20.0
                )
            )
          ],
        )
      )
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "設定",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF4CBBB4),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contents
            ),
          ),
        )
    );
  }
}