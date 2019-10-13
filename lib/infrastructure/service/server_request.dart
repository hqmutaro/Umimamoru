import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/infrastructure/service/domain_data.dart';

class ServerRequest {

  Future<void> request(String beachName) async{
    var serverProvider = ServerProvider();
    var domainData = DomainData.getInstance();

    // Beach
    var beachResponse = await serverProvider.response("/net/beach", "?beach=$beachName");
    var beachDataList = json.decode(beachResponse.body) as List;
    Map<String, dynamic> beachMap = beachDataList.first;
    await domainData.setBeachMap(beachMap);
    print(beachMap);

    // Module
    var moduleResponse = await serverProvider.response("/net/module", "?net=${beachMap["net"]}");
    var moduleDataList = json.decode(moduleResponse.body) as List;
    var moduleListMap = <String, dynamic>{};

    print(moduleDataList);

    for (Map<String, dynamic> moduleData in moduleDataList) {
      var module = await moduleListed(beachMap["net"], moduleData);
      moduleListMap[module["loc"].toString()] = module;
    }
    await domainData.setModuleMap(moduleListMap);
    print(moduleListMap);

    // Pole
    var poleResponse = await serverProvider.response("/net/pole", "?net=${beachMap["net"]}");
    var poleDataList = json.decode(poleResponse.body) as List;
    var poleMapList = <String, dynamic>{};

    for (Map<String, dynamic> poleData in poleDataList) {
      var pole = await poleListed(beachMap["net"], poleData);
      poleMapList[pole["loc"].toString()] = pole;
    }
    await domainData.setPoleMap(poleMapList);
    //print(poleMapList);
  }

  Future<Map<String, dynamic>> moduleListed(int net, Map<String, dynamic> map) async{
    var flowResponse = await ServerProvider().response("/net/flow", "?net=$net");
    //print(flowResponse.body);
    var flowDataList = json.decode(flowResponse.body) as List;
    print("flow $flowDataList");
    var flowData = flowDataList.first["flow"] as Map;
    return <String, dynamic>{
      "loc": map["loc"],
      "wave.level": getLevelToString(getLevel(flowData["flow"])),
      "wave.speed": double.parse(flowData["flow"].toStringAsFixed(1)),
      "count.occur": flowDataList[0],
      "latitude": map["latitude"],
      "longitude": map["longitude"]
    };
  }

  Future<Map<String, dynamic>> poleListed(int net, Map<String, dynamic> map) async {
    var flowResponse = await ServerProvider().response(
        "/pole/flow", "?loc=${map["loc"]}&net=$net");
    var flowDataList = json.decode(flowResponse.body) as List;
    print(flowDataList);
    var flowData = flowDataList.first as Map;

    return <String, dynamic>{
      "net": flowData["flow"]["net"],
      "loc": flowData["flow"]["loc"],
      "wave.speed": flowData["flow"]["flow"],
      "latitude": map["latitude"],
      "longitude": map["longitude"],
    };
  }
}