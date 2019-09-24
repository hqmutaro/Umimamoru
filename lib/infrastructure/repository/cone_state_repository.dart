import 'package:umimamoru/domain/cone_state.dart';
import 'package:umimamoru/domain/repository/state_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';

import 'cone_state_dto.dart';

class ConeStateRepository implements StateRepository{

  @override
  Future<List<ConeState>> coneState(String beach) async{
    final List<ConeState> coneStateList = [];
    // Serverからデータを取る
    Map<String, Map<String, dynamic>> data = {
      "1番コーン": {
        "wave.speed": 0.3,
        "count.occur": 3,
        "latitude" : 26.511436,
        "longitude" : 128.028748
      },
      "2番コーン": {
        "wave.speed": 0.5,
        "count.occur": 1,
        "latitude" : 26.510998,
        "longitude" : 128.028935
      },
      "3番コーン": {
        "wave.speed": 0.8,
        "count.occur": 4,
        "latitude" : 26.511198,
        "longitude" : 128.027792
      },
      "4番コーン": {
        "wave.speed": 1.4,
        "count.occur": 3,
        "latitude" : 26.510583,
        "longitude" : 128.027933
      },
      "5番コーン": {
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
      coneStateList.add(ConeStateDTO.decode(stateMap));
    });
    return coneStateList;
  }

}