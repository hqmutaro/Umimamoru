import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:umimamoru/domain/beach.dart';

import 'package:umimamoru/domain/module.dart';
import 'package:umimamoru/domain/repository/module_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';

import 'dto/module_dto.dart';

class ServerModuleRepository implements ModuleRepository {

  @override
  Future<List<Module>> moduleState(Beach beach) async {
    var url = "http://35.247.121.242:8080/Umimamoru/umimamoru";
    var net = beach.net;
    var moduleResponse = await http.get(
        url + "/net/module?net=$net",
        headers: {"Content-Type": "application/json"}
    );
    List moduleDataList = json.decode(moduleResponse.body);
    print(moduleDataList.first["latitude"]);

    var moduleStateList = <Module>[];
    print("moduledata: $moduleDataList");
    for (Map<String, dynamic> moduleData in moduleDataList) {
      var module = await moduleListed(net, url, moduleData);
      moduleStateList.add(module);
    }
    return moduleStateList;
  }

  Future<Module> moduleListed(int net, String url, Map<String, dynamic> map) async {
    var flowResponse = await http.get(
        url + "/net/flow?net=$net",
        headers: {"Content-Type": "application/json"}
    );
    List flowDataList = json.decode(flowResponse.body);
    Map flowData = flowDataList[map["loc"] - 1]["flow"];
    return ModuleDTO.decode(<String, dynamic>{
      "loc": map["loc"],
      "wave.level": getLevelToString(getLevel(flowData["flow"])),
      "wave.speed": double.parse(flowData["flow"].toStringAsFixed(1)),
      "count.occur": flowDataList[map["loc"] - 1]["count"],
      "latitude": map["latitude"],
      "longitude": map["longitude"]
    });
  }

}