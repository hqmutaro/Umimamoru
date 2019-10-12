import 'dart:async';
import 'dart:convert';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/infrastructure/service/data_holder.dart';

class ServerRequest {

  Future<void> request(String beachName) async{
    var dataHolder = DataHolder(beachName: "シーグラスビーチ");
    // Beach
    var beachResponse = await ServerProvider().response("/net/beach", "?beach=$beachName");
    final List<dynamic> list = json.decode(beachResponse.body);
    Map<String, dynamic> beachMap = list.first;
    dataHolder.setBeachMap(beachMap);

    // Module
    var moduleResponse = await ServerProvider().response("/net/module", "?net=${beachMap["net"]}");
    var moduleDataList = json.decode(moduleResponse.body) as List;

    for (Map<String, dynamic> moduleData in moduleDataList) {
      var module = await moduleListed(beachMap["net"], moduleData);
      dataHolder.setModuleMap(module["loc"], module);
    }

    // Pole
    var poleResponse = await ServerProvider().response("/net/pole", "?net=${beachMap["net"]}");
    var poleDataList = json.decode(poleResponse.body) as List;

    for (Map<String, dynamic> poleData in poleDataList) {
      var pole = await poleListed(beachMap["net"], poleData);
      dataHolder.setPoleMap(beachMap["net"], pole);
    }
  }

  Future<Map<String, dynamic>> moduleListed(int net, Map<String, dynamic> map) async{
    var flowResponse = await ServerProvider().response("/net/flow", "?net=$net");
    var flowDataList = json.decode(flowResponse.body) as List;
    var flowData = flowDataList[map["loc"] - 1]["flow"] as Map;

    return <String, dynamic>{
      "loc": map["loc"],
      "wave.level": getLevelToString(getLevel(flowData["flow"])),
      "wave.speed": double.parse(flowData["flow"].toStringAsFixed(1)),
      "count.occur": flowDataList[map["loc"] - 1]["count"],
      "latitude": map["latitude"],
      "longitude": map["longitude"]
    };
  }

  Future<Map<String, dynamic>> poleListed(int net, Map<String, dynamic> map) async{
    var flowResponse = await ServerProvider().response("/pole/flow", "?loc=${map["loc"]}&net=$net");
    var flowDataList = json.decode(flowResponse.body) as List;
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