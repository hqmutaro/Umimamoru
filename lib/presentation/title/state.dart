import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/title/title.dart' as title;
import 'package:umimamoru_flutter/presentation/selector/main.dart';

class TitleState extends State<title.Title> {
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
      body:
      Center(
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
                style: TextStyle(fontSize:49.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
              ),
                  RaisedButton(key:null, onPressed:buttonPressed,
                      color: Color(0xFFe0e0e0),
                      child:
                      Text(
                        "地域を選択する",
                        style: TextStyle(fontSize:25.0,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto"),
                      )
                  ),
              Padding(
                padding: EdgeInsets.only(top: 200, left: 250),
                  child: IconButton(
                    iconSize: 60,
                    onPressed: null,
                    color: Colors.blue,
                    icon: Icon(Icons.settings),
                  )
              )
            ]
        ),
      ),
    );
  }

  buttonPressed(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchList()));
  }
}