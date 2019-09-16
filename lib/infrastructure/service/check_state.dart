import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:umimamoru/infrastructure/repository/cone_state_repository.dart';
import 'package:umimamoru/infrastructure/service/occurring_manager.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/application/notification/notification.dart' as local;
import 'package:umimamoru/presentation/home/main.dart';

class CheckState{

  final BuildContext context;

  const CheckState({this.context});

  void checkState() async{
    // ふぁぼったビーチを取得
    // 各ビーチのコーンを取得
    // コーンの状態を調べて離岸流が発生してたら通知する
    // TODO: ふぁぼる機能実装しろ
    var provider = WatchProvider.getInstance();
    var watches = await provider.getWatches();
    var repository = ConeStateRepository();
    var occurringManager = OccurringManager.getInstance();
    watches.forEach((watch) async{
      var coneStateList = await repository.coneState(watch);

      Map<String, bool> isOccurringMap = {};
      coneStateList.forEach((entity) async{
        if (entity.level == getLevelToString(Level.Fast)) {
          isOccurringMap[entity.cone] = true;
          if (await occurringManager.isOccurring(watch)) {
            isOccurringMap[entity.cone] = false; // ビーチで離岸流が発生しているか判定するため
        }
        else {
          local.Notification(
              flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
              context: this.context,
              dialogTitle: "$watchにて離岸流が発生しました",
              title: "離岸流が発生しました",
              body: watch,
              payload: "やばいわよ"
          )
            ..setUp()
            ..showNotification();
          occurringManager.setOccurring(watch);
          } // すでに発生していることを通知したなら通知しない
        }
      });
      coneStateList.forEach((entity) {
        isOccurringMap.forEach((cone, isOccurring) async{
          if (isOccurring) {
            await occurringManager.setOccurring(watch); // 離岸流が発生していると判定した時点で発生リストに追加, 処理終わり
            return;
          }
        });
      });
      if (await occurringManager.isOccurring(watch)) {// 離岸流が発生している判定だったら外す
        await occurringManager.deleteOccurring(watch);
      }
    });
  }
}