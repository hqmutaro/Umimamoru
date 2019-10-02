import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/repository/beach_repository.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:umimamoru/infrastructure/repository/dto/beach_dto.dart';

class ServerBeachRepository extends BeachRepository {
  
  @override
  Future<Beach> beachData(String beach) async{
    var url = "http://35.247.121.242:8080/Umimamoru/umimamoru";
    var beachData = await http.get(
        url + "/net/beach""?beach=シーグラスビーチ",
        headers: {"Content-Type" : "application/json"}
    );
    final list = convert.json.decode(beachData.body);
    Map<String, dynamic> map = list[0];
    return BeachDTO.decode(map);
  }
}