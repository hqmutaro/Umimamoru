import 'dart:convert';

import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/domain/pole.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/repository/pole_repository.dart';
import 'package:umimamoru/infrastructure/repository/dto/pole_dto.dart';
import 'package:http/http.dart' as http;
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/infrastructure/service/data_holder.dart';
import 'package:umimamoru/infrastructure/service/server_request.dart';

class ServerPoleRepository implements PoleRepository {

  @override
  Future<List<Pole>> poleState(String beachName) async{
    if (Debug.isDebugMode()) {
      return <Pole>[
        PoleDTO.debug()
      ];
    }

    var poleList = <Pole>[];
    var poleDataList = ServerRequest.dataHolder.getPoleList();
    for (Map<String, dynamic> poleData in poleDataList) {
      poleList.add(PoleDTO.decode(poleData));
    }
    return poleList;
  }
}