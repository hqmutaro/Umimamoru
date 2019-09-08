import 'package:umimamoru/domain/cone_state.dart';

class ConeStateDTO {

  static ConeState decode(Map<String, dynamic> map) {
    return ConeState(
      map["beach"] as String,
      map["cone"] as String,
      map["waveLevel"] as String,
      map["waveSpeed"] as num,
      map["countOccur"] as num
    );
  }

  static Map<String, dynamic> encode(ConeState coneState) {
    return <String, dynamic>{
      "beach" : coneState.beach,
      "cone" : coneState.cone,
      "waveLevel" : coneState.level,
      "waveSpeed" : coneState.speed,
      "countOccur" : coneState.countOccur
    };
  }
}