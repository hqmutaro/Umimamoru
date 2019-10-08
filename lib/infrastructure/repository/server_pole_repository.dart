import 'dart:convert';

import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/domain/pole.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/repository/pole_repository.dart';
import 'package:umimamoru/infrastructure/repository/dto/pole_dto.dart';
import 'package:http/http.dart' as http;

class ServerPoleRepository implements PoleRepository {

  @override
  Future<List<Pole>> poleState(Beach beach) async{
    if (Debug.isDebugMode()) {
      return <Pole>[
        PoleDTO.debug()
      ];
    }
    var url = "http://35.247.121.242:8080/Umimamoru/umimamoru";
    var net = beach.net;
    var poleResponse = await http.get(
      url + "/net/pole?net=$net",
      headers: {"Content-Type": "application/json"}
    );
    var poleDataList = json.decode(poleResponse.body) as List;

    var poleList = <Pole>[];
    for (Map<String, dynamic> poleData in poleDataList) {
      var pole = await poleListed(net, url, poleData);
      poleList.add(pole);
    }
    return poleList;
  }

  Future<Pole> poleListed(int net, String url, Map<String, dynamic> map) async{
    var flowResponse = await http.get(
      url + "/pole/flow?loc=${map["loc"]}&net=$net",
      headers: {"Content-Type": "application/json"}
    );
    var flowDataList = json.decode(flowResponse.body) as List;
    var flowData = flowDataList.first as Map;
    return PoleDTO.decode(<String, dynamic>{
      "net": flowData["flow"]["net"],
      "loc": flowData["flow"]["loc"],
      "wave.speed": flowData["flow"]["flow"],
      "latitude": map["latitude"],
      "longitude": map["longitude"],
    });
  }
}