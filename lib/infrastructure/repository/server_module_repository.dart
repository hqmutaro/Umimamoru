import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/domain/beach.dart';

import 'package:umimamoru/domain/module.dart';
import 'package:umimamoru/domain/repository/module_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/infrastructure/service/data_holder.dart';
import 'package:umimamoru/infrastructure/service/server_request.dart';

import 'dto/module_dto.dart';

class ServerModuleRepository implements ModuleRepository {

  @override
  Future<List<Module>> moduleState(String beachName) async{
    if (Debug.isDebugMode()) {
      return <Module>[
        ModuleDTO.decode(<String, dynamic>{
          "loc": 1,
          "wave.level": "Fast",
          "wave.speed": 1.8,
          "count.occur": 3,
          "latitude": 22.0,
          "longitude": 140.0
        })
      ];
    }

    var moduleList = <Module>[];
    var moduleDataList = ServerRequest.dataHolder.getModuleMap();
    for (Map<String, dynamic> moduleData in moduleDataList) {
      moduleList.add(ModuleDTO.decode(moduleData));
    }
    return moduleList;
  }

}