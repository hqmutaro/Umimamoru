import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/image_action_bloc.dart';
import 'package:umimamoru/infrastructure/service/check_state.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';
import 'package:umimamoru/presentation/home/main.dart';

class App extends StatelessWidget {

  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checkState = CheckState(context: context);
    var methodChannel = const MethodChannel("com.github.nitf");
    methodChannel.setMethodCallHandler((call) async{
      checkState.checkState();
      print("checked");
    });
    return UmimamoruTheme(
      title: "うみまもる",
      home: Home(),
    );
  }
}