import 'package:umimamoru/domain/module.dart';

class ModuleDTO {

  static Module decode(Map<String, dynamic> map) {
    print("Map $map");
    return Module(
      map["loc"] as num,
      map["wave.level"] as String,
      map["wave.speed"] as num,
      map["count.occur"]["count"] as num,
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

  static Module debug() {
    return Module(
      1,
      "Fast",
      1.7,
      4,
      24,
      150
    );
  }
}