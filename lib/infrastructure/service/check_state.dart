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
   var provider = WatchProvider.getInstance();
   var watchBeaches = await provider.getWatchBeaches();
   var repository = ConeStateRepository();
   var occurringManager = OccurringManager.getInstance();

   watchBeaches.forEach((beach) async{
     var isOccurringMap = <String, bool>{};
     var coneStateList = await repository.coneState(beach);
     var isOccurring = await occurringManager.isOccurring(beach);
     coneStateList.forEach((model) async{
       if (model.level == getLevelToString(Level.Fast)) {
         isOccurringMap[model.cone] = true;
       }
       else {
         isOccurringMap[model.cone] = false;
       }
     });
     var isOccurringBeach = false;
     coneStateList.forEach((model) async{
       if (isOccurringMap[model.cone]) {
         if (!isOccurring) {
           local.Notification(
               flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
               context: this.context,
               dialogTitle: "$beachにて離岸流が発生しました",
               title: "離岸流が発生しました",
               body: "にゃん",
               payload: isOccurringMap.keys.where((key) => isOccurringMap[key]).toString()
           )
             ..setUp()
             ..showNotification();
           await occurringManager.setOccurring(beach);
           isOccurringBeach = true;
           return;
         }
       }
     });
     if ((isOccurringBeach) && (isOccurring)) {
       await occurringManager.deleteOccurring(beach);
     }
   });
  }
}