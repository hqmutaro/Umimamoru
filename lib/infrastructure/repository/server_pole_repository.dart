import 'dart:convert';

import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/domain/pole.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/repository/pole_repository.dart';
import 'package:umimamoru/infrastructure/repository/dto/pole_dto.dart';
import 'package:http/http.dart' as http;
import 'package:umimamoru/infrastructure/repository/server_provider.dart';

class ServerPoleRepository implements PoleRepository {

  @override
  Future<List<Pole>> poleState(Beach beach) async{
    if (Debug.isDebugMode()) {
      return <Pole>[
        PoleDTO.debug()
      ];
    }
    var poleResponse = await ServerProvider().response("/net/pole", "?net=${beach.net}");
    var poleDataList = json.decode(poleResponse.body) as List;

    var poleList = <Pole>[];
    for (Map<String, dynamic> poleData in poleDataList) {
      var pole = await poleListed(beach.net, poleData);
      poleList.add(pole);
    }
    return poleList;
  }

  Future<Pole> poleListed(int net, Map<String, dynamic> map) async{
    var flowResponse = await ServerProvider().response("/pole/flow", "?loc=${map["loc"]}&net=$net");
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