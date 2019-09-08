import 'package:umimamoru/domain/cone_state.dart';
import 'package:umimamoru/domain/repository/state_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';

import 'cone_state_dto.dart';

class ConeStateRepository implements StateRepository{

  Future<List<ConeState>> coneState(String beach) async{
    final List<ConeState> coneStateList = [];
    // Serverからデータを取る
    Map<String, Map<String, dynamic>> data = {
      "1番コーン": {
        "wave.speed": 0.3,
        "count.occur": 3
      },
      "2番コーン": {
        "wave.speed": 0.5,
        "count.occur": 1
      },
      "3番コーン": {
        "wave.speed": 0.8,
        "count.occur": 4
      },
      "4番コーン": {
        "wave.speed": 1.4,
        "count.occur": 3
      },
      "5番コーン": {
        "wave.speed": 1.8,
        "count.occur": 2
      }
    };
    data.forEach((cone, data) {
      Map<String, dynamic> stateMap = {
        "beach" : beach,
        "cone" : cone,
        "waveLevel" : getLevelToString(getLevel(data["wave.speed"])),
        "waveSpeed" : data["wave.speed"],
        "countOccur" : data["count.occur"]
      };
      coneStateList.add(ConeStateDTO.decode(stateMap));
    });
    return coneStateList;
  }

}