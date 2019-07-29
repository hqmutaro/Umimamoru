import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/domain/cone_state.dart';
import 'package:umimamoru_flutter/application/repository/repository.dart';
import 'package:umimamoru_flutter/infrastructure/server/data_task.dart';
import 'package:umimamoru_flutter/domain/entity.dart';

class ConeStateRepository extends Repository{

  Entity entity;
  String beach;
  DataTask task;

  ConeStateRepository(@required beach) : assert(beach != null) {
    this.task = DataTask(beach);
  }

  void setEntity(Entity entity) {
    this.entity = entity;
  }

  List<ConeState> getEntities() {
    this.task.sendToEntity();
    return this.task.getResult();
  }
}