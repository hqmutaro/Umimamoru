import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum _DialogActionType {
  Cancel,
  OK,
}

class Notification {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BuildContext context;

  final String dialogTitle;
  final String title;
  final String body;
  final String payload;

  const Notification({
    @required this.flutterLocalNotificationsPlugin,
    @required this.context,
    @required this.dialogTitle,
    @required this.title,
    @required this.body,
    @required this.payload
  });

  void setUp() {
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(
        initSettings,
        onSelectNotification: onSelectNotification
    );
  }

  Future<void> onSelectNotification(String payload) async{
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(this.dialogTitle),
        content: Text(payload),
        actions: <Widget>[
          FlatButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context, _DialogActionType.Cancel);
              }),
          FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context, _DialogActionType.OK);
              })
        ],
      ),
    ).then((value) {
      switch (value) {
        case _DialogActionType.Cancel:
          print("cancel...");
          break;
        case _DialogActionType.OK:
          print("OK!!");
          break;
        default:
          print("default");
      }
    });
  }

  Future<void> showNotification() async{
    var android = AndroidNotificationDetails(
        'umimamoru',
        'うみまもる',
        '離岸流情報アプリ',
        priority: Priority.High,importance: Importance.Max
    );
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0,
        this.title,
        this.body,
        platform,
        payload: this.payload
    );
  }
}