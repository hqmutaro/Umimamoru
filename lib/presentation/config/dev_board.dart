import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/watching_beach_bloc.dart';
import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/presentation/config/watching_list.dart';
import 'package:umimamoru/presentation/ui/button/previous_button.dart';
import '../umimamoru_theme.dart';

class DevBoard extends StatefulWidget {

  const DevBoard({Key key}) : super(key: key);

  @override
  _DevBoard createState() => _DevBoard();
}

class _DevBoard extends State<DevBoard> {

  bool _isDebugMode = Debug.isDebugMode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: UmimamoruTheme.colorTheme,
            title: Text("開発", style: TextStyle(color: Colors.white))
        ),
        body: Column(
          children: <Widget>[
            PreviousButton(message: "設定に戻る"),
            SwitchListTile(
              value: _isDebugMode,
              title: Text("デバッグモード"),
              onChanged: (bool value) {
                setState(() {
                  _isDebugMode = value;
                  _isDebugMode ? Debug.onDebugMode() : Debug.unDebugMode();
                });
              }
            )
          ],
        )
    );
  }
}