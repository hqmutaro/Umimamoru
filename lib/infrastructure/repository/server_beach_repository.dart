import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/repository/beach_repository.dart';
import 'dart:convert';
import 'package:umimamoru/infrastructure/repository/dto/beach_dto.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/infrastructure/service/data_holder.dart';
import 'package:umimamoru/infrastructure/service/server_request.dart';

class ServerBeachRepository extends BeachRepository {
  
  @override
  Future<Beach> beachData(String beachName) async{
    if (Debug.isDebugMode()) {
      return BeachDTO.debug();
    }
    var beachData = ServerRequest.dataHolder.getBeachMap();
    return BeachDTO.decode(beachData);
  }
}