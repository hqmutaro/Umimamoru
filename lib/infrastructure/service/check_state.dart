import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/image_action_bloc.dart';
import 'package:umimamoru/domain/module.dart';
import 'package:umimamoru/domain/repository/beach_repository.dart';
import 'package:umimamoru/infrastructure/repository/server_beach_repository.dart';
import 'package:umimamoru/infrastructure/repository/server_module_repository.dart';
import 'package:umimamoru/infrastructure/service/occurring_manager.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/application/notification/notification.dart' as local;

class CheckState {

  final BuildContext context;
  Map<String, bool> _isOccurringMap;
  bool _isOccurringBeach;
  bool _isOccurring;
  bool _isNoticed = false;
  String _beach;
  OccurringManager _occurringManager;
  ServerModuleRepository _serverModuleRepository;

  CheckState({this.context}) {
    this._occurringManager = OccurringManager.getInstance();
    this._serverModuleRepository = ServerModuleRepository();
  }

  void checkState() async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return;
    if (Debug.isDebugMode()) return;
    var provider = WatchProvider.getInstance();
    var watchBeaches = await provider.getWatchBeaches();
    watchBeaches.forEach((beach) => this.run(beach));
  }

  Future<void> run(String beach) async{
    this._isOccurringMap = <String, bool>{};
    this._isOccurringBeach = false;
    this._isOccurring = await this._occurringManager.isOccurring(beach);
    this._beach = beach;
    var beachData = await ServerBeachRepository().beachData(beach);
    var moduleList = await this._serverModuleRepository.moduleState(beachData);

    moduleList.forEach((model) => this.checkOccurring(model)); // 離岸流の発生判定を行う
    moduleList.forEach((model) => this.sendNotification(model)); // 条件を判定しながら通知を行う
    if ((!this._isOccurringBeach) && (this._isOccurring)) {
      await this._occurringManager.deleteOccurring(beach);
    }
  }

  Future<void> checkOccurring(Module model) async{
    if (model.level == getLevelToString(Level.Fast)) {
      this._isOccurringMap[model.id.toString()] = true;
    }
    else {
      this._isOccurringMap[model.id.toString()] = false;
    }
  }

  Future<void> sendNotification(Module model) async{
    if (this._isOccurringMap[model.id.toString()]) {
      this._isOccurringBeach = true;
      if ((!this._isOccurring) && (!this._isNoticed)) {
        local.Notification(
            flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
            context: this.context,
            dialogTitle: "${this._beach}にて離岸流が発生しました",
            title: "監視している海水浴場にて離岸流が発生しました",
            body: "対象の海水浴場: ${this._beach}",
            payload: _isOccurringMap.keys.where((key) => _isOccurringMap[key]).toString()
        )
          ..setUp()
          ..showNotification();
        this._isNoticed = true;
        await this._occurringManager.setOccurring(this._beach);
      }
    }
  }
}