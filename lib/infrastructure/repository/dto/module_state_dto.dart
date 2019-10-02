import 'package:umimamoru/domain/module_state.dart';

class ModuleStateDTO {

  static ModuleState decode(Map<String, dynamic> map) {
    return ModuleState(
      map["beach"] as String,
      map["cone"] as String,
      map["waveLevel"] as String,
      map["waveSpeed"] as num,
      map["countOccur"] as num,
      map["latitude"] as num,
      map["longitude"] as num
    );
  }

  static Map<String, dynamic> encode(ModuleState coneState) {
    return <String, dynamic>{
      "beach" : coneState.beach,
      "cone" : coneState.module,
      "waveLevel" : coneState.level,
      "waveSpeed" : coneState.speed,
      "countOccur" : coneState.countOccur,
      "latitude" : coneState.latitude,
      "longitude" : coneState.longitude
    };
  }
}