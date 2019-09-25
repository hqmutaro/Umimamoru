import 'package:umimamoru/domain/module_state.dart';
import 'package:umimamoru/domain/repository/state_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';

import 'module_state_dto.dart';

class ModuleStateRepository implements StateRepository{

  @override
  Future<List<ModuleState>> moduleState(String beach) async{
    final List<ModuleState> moduleStateList = [];
    // Serverからデータを取る
    Map<String, Map<String, dynamic>> data = {
      "1番モジュール": {
        "wave.speed": 0.3,
        "count.occur": 3,
        "latitude" : 26.511436,
        "longitude" : 128.028748
      },
      "2番モジュール": {
        "wave.speed": 0.5,
        "count.occur": 1,
        "latitude" : 26.510998,
        "longitude" : 128.028935
      },
      "3番モジュール": {
        "wave.speed": 0.8,
        "count.occur": 4,
        "latitude" : 26.511198,
        "longitude" : 128.027792
      },
      "4番モジュール": {
        "wave.speed": 1.4,
        "count.occur": 3,
        "latitude" : 26.510583,
        "longitude" : 128.027933
      },
      "5番モジュール": {
        "wave.speed": 1.8,
        "count.occur": 2,
        "latitude" : 26.510862,
        "longitude" : 128.026965
      }
    };
    data.forEach((cone, data) {
      Map<String, dynamic> stateMap = {
        "beach" : beach,
        "cone" : cone,
        "waveLevel" : getLevelToString(getLevel(data["wave.speed"])),
        "waveSpeed" : data["wave.speed"],
        "countOccur" : data["count.occur"],
        "latitude" : data["latitude"],
        "longitude" : data["longitude"]
      };
      moduleStateList.add(ModuleStateDTO.decode(stateMap));
    });
    return moduleStateList;
  }

}