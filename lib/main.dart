import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umimamoru/infrastructure/server/check_state.dart';
import 'package:umimamoru/presentation/app.dart';

void main() {
  var checkState = CheckState();
  var methodChannel = const MethodChannel("com.github.nitf");
  methodChannel.setMethodCallHandler((call) async{
    checkState.checkState();
  });
  runApp(App());
}