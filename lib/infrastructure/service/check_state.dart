import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:umimamoru/domain/module_state.dart';
import 'package:umimamoru/infrastructure/repository/module_state_repository.dart';
import 'package:umimamoru/infrastructure/service/occurring_manager.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/application/notification/notification.dart' as local;

class CheckState {

  final BuildContext context;
  Map<String, bool> _isOccurringMap;
  bool _isOccurringBeach;
  bool _isOccurring;
  String _beach;
  OccurringManager _occurringManager;
  ModuleStateRepository _coneStateRepository;

  CheckState({this.context}) {
    this._occurringManager = OccurringManager.getInstance();
    this._coneStateRepository = ModuleStateRepository();
  }

  void checkState() async{
   var provider = WatchProvider.getInstance();
   var watchBeaches = await provider.getWatchBeaches();
   watchBeaches.forEach((beach) => this.run(beach));
  }

  Future<void> run(String beach) async{
    this._isOccurringMap = <String, bool>{}; // initializing
    this._isOccurringBeach = false; // initializing
    this._isOccurring = await this._occurringManager.isOccurring(beach); // initializing
    this._beach = beach; // initializing
    var coneStateList = await this._coneStateRepository.moduleState(beach);

    coneStateList.forEach((model) => this.checkOccurring(model)); // 離岸流の発生判定を行う
    coneStateList.forEach((model) => this.sendNotification(model)); // 条件を判定しながら通知を行う

    if ((!this._isOccurringBeach) && (this._isOccurring)) {
      await this._occurringManager.deleteOccurring(beach);
    }
  }

  Future<void> checkOccurring(ModuleState model) async{
    if (model.level == getLevelToString(Level.Fast)) {
      this._isOccurringMap[model.module] = true;
    }
    else {
      this._isOccurringMap[model.module] = false;
    }
  }

  Future<void> sendNotification(ModuleState model) async{
    if (this._isOccurringMap[model.module]) {
      this._isOccurringBeach = true;
      if (!this._isOccurring) {
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
        await this._occurringManager.setOccurring(this._beach);
      }
    }
  }
}