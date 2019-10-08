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

  static Map<String, dynamic> encode(Module module) {
    return <String, dynamic>{
      "id" : module.id,
      "waveLevel" : module.level,
      "waveSpeed" : module.speed,
      "countOccur" : module.countOccur,
      "latitude" : module.latitude,
      "longitude" : module.longitude
    };
  }
}