import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/repository/beach_repository.dart';
import 'dart:convert';
import 'package:umimamoru/infrastructure/repository/dto/beach_dto.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';

class ServerBeachRepository extends BeachRepository {
  
  @override
  Future<Beach> beachData(String beach) async{
    if (Debug.isDebugMode()) {
      return BeachDTO.debug();
    }
    var beachResponse = await ServerProvider().response("/net/beach", "?beach=$beach");
    final List<dynamic> list = json.decode(beachResponse.body);
    Map<String, dynamic> map = list.first;

    return BeachDTO.decode(map);
  }
}