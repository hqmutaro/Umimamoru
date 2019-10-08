import 'package:umimamoru/domain/pole.dart';

class PoleDTO {

  static Pole decode(Map<String, dynamic> map) {
    return Pole(
      map["net"] as num,
      map["loc"] as num,
      map["wave.speed"] as num,
      map["latitude"] as num,
      map["longitude"] as num
    );
  }

  static Map<String, dynamic> encode(Pole pole) {
    return <String, dynamic>{
      "net": pole.net,
      "loc": pole.loc,
      "wave.speed": pole.speed,
      "latitude": pole.latitude,
      "longitude": pole.longitude
    };
  }

  static Pole debug() {
    return Pole(
      0,
      1,
      1.7,
      20,
      140
    );
  }
}