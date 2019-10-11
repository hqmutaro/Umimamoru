import 'package:flutter/material.dart';

void notActivityPopup(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            title: Text("サーバエラー"),
            content: Text("サーバがダウンしています。\n復旧までしばらくお待ちください。"),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  color: Colors.blue[800],
                  child: Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      )
                  )
              )
            ]
        );
      }
  );
}