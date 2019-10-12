import 'dart:core';

import 'package:flutter/material.dart';

class DataHolder {

  Map<String, dynamic> beachMap = {};
  Map<String, Map<String, dynamic>> moduleMap = {};
  Map<String, Map<String, dynamic>> poleMap = {};

  String beachName;

  DataHolder({@required this.beachName});

  void setBeachMap(Map<String, dynamic> map) => beachMap = map;

  Map<String, dynamic> getBeachMap() => beachMap;

  void setModuleMap(String moduleName, Map<String, dynamic> map) => moduleMap[moduleName] = map;

  List<Map<String, dynamic>> getModuleMap() => moduleMap.values.toList();

  void setPoleMap(String poleName, Map<String, dynamic> map) => poleMap[poleName] = map;

  List<Map<String, dynamic>> getPoleList() => poleMap.values.toList();
}