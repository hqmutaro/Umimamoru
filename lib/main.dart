import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umimamoru/infrastructure/service/check_state.dart';
import 'package:umimamoru/infrastructure/service/occurring_manager.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';
import 'package:umimamoru/presentation/app.dart';

void main() async{
  await WatchProvider().init();
  await OccurringManager().init();
  var provider = WatchProvider.getInstance();
  //await provider.addBeach("1919");
  var watches = await provider.getWatches();
  watches.forEach((watch) => print(watch));
  runApp(App());
}