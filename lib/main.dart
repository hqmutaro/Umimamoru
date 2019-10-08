import 'package:flutter/material.dart';
import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/infrastructure/service/occurring_manager.dart';
import 'package:umimamoru/infrastructure/service/server_request.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';
import 'package:umimamoru/presentation/app.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async{
  await WatchProvider().init();
  await OccurringManager().init();
  var provider = WatchProvider.getInstance();

  // var manager = OccurringManager.getInstance();
  // await provider.addBeach("");
  // await provider.removeBeach("");
  // await manager.deleteOccurring("");

  var watchBeaches = await provider.getWatchBeaches();
  watchBeaches.forEach((watch) => print(watch));
  runApp(App());
}