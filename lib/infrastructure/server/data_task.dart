import 'dart:async';
import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/domain/cone_state.dart';

class DataTask {

  Map data = {
    "1番コーン" : {
      "state" : "calm",
      "wave.speed" : 3,
      "count.occur" : 2
    },
    "2番コーン" : {
      "state" : "ordinarily",
      "wave.speed" : 4,
      "count.occur" : 3
    },
    "3番コーン" : {
      "state" : "ordinarily",
      "wave.speed" : 5,
      "count.occur" : 4
    },
    "4番コーン" : {
      "state" : "fast",
      "wave.speed" : 6,
      "count.occur" : 5
    },
    "5番コーン" : {
      "state" : "fast",
      "wave.speed" : 7,
      "count.occur" : 5
    },
  };

  static const int TIME = 5;
  String beach;
  List result = [];

  DataTask(@required this.beach) : assert(beach != null);

  void sendToEntity() async{
    var data = await _getData();
    data.forEach((cone, data) => this.result.add(
      ConeState(
        cone,
        data["level"],
        data["wave.speed"],
        data["count.occur"]
      )
    ));
  }

  List<ConeState> getResult() => this.result;

  Future<Map> _getData() {
    return new Future.delayed(new Duration(seconds: TIME), (){
      return this.data;
    });
  }
}