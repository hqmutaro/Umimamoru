import 'dart:convert';

import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/domain/pole.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/repository/pole_repository.dart';
import 'package:umimamoru/infrastructure/repository/dto/pole_dto.dart';
import 'package:http/http.dart' as http;
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/infrastructure/service/domain_data.dart';

class ServerPoleRepository implements PoleRepository {

  @override
  Future<List<Pole>> poleState(String beach) async{
    if (Debug.isDebugMode()) {
      return <Pole>[PoleDTO.debug()];
    }
    var poleList = <Pole>[];
    var poleDataMap = await DomainData.getInstance().getPoleMap();
    poleDataMap.forEach((pole, data) {
      poleList.add(PoleDTO.decode(data));
    });
    return poleList;
  }
}