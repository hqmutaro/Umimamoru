import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/domain/beach.dart';

import 'package:umimamoru/domain/module.dart';
import 'package:umimamoru/domain/repository/module_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/infrastructure/service/domain_data.dart';

import 'dto/module_dto.dart';

class ServerModuleRepository implements ModuleRepository {

  @override
  Future<List<Module>> moduleState(String beach) async{
    if (Debug.isDebugMode()) {
      return <Module>[ModuleDTO.debug()];
  }
  var moduleList = <Module>[];
  var moduleDataMap = await DomainData.getInstance().getModuleMap();
  moduleDataMap.forEach((module, data) {
      moduleList.add(ModuleDTO.decode(data));
    });
    return moduleList;
  }
}