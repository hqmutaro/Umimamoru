import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/watching_beach_bloc.dart';
import 'package:umimamoru/presentation/config/watching_list.dart';
import 'package:umimamoru/presentation/ui/button/previous_button.dart';
import '../umimamoru_theme.dart';

class WatchingView extends StatefulWidget {

  const WatchingView({Key key}) : super(key: key);

  @override
  _WatchingView createState() => _WatchingView();
}

class _WatchingView extends State<WatchingView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: UmimamoruTheme.colorTheme,
            title: Text("Watchingリスト", style: TextStyle(color: Colors.white))
        ),
        body: Column(
          children: <Widget>[
            PreviousButton(message: "設定に戻る"),
            BlocProvider<WatchingBeachBloc>(
                bloc: WatchingBeachBloc(),
                child: WatchingList()
            )
          ],
        )
    );
  }
}