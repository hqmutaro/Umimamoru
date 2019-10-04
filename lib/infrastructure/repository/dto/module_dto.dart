import 'package:umimamoru/domain/module.dart';

class ModuleDTO {

  static Module decode(Map<String, dynamic> map) {
    return Module(
      map["loc"] as num,
      map["wave.level"],
      map["wave.speed"] as num,
      map["count.occur"] as num,
      map["latitude"] as num,
      map["longitude"] as num
    );
  }

  static Map<String, dynamic> encode(Module coneState) {
    return <String, dynamic>{
      "id" : coneState.id,
      "waveLevel" : coneState.level,
      "waveSpeed" : coneState.speed,
      // "countOccur" : coneState.countOccur,
      "latitude" : coneState.latitude,
      "longitude" : coneState.longitude
    };
  }
}