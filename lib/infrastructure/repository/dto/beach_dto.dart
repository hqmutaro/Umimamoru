import 'package:umimamoru/domain/beach.dart';

class BeachDTO {

  static Beach decode(Map<String, dynamic> map) {
    return Beach(
      map["beach"] as String,
      map["pref"] as String,
      map["latitude"] as num,
      map["longitude"] as num,
      map["net"] as num
    );
  }

  static Map<String, dynamic> encode(Beach beach) {
    return <String, dynamic>{
      "beach" : beach.name,
      "pref" : beach.pref,
      "latitude" : beach.latitude,
      "longitude" : beach.longitude,
      "net" : beach.net,
    };
  }

  static Beach debug() {
    return Beach(
      "シーグラスビーチ",
      "沖縄県",
      20,
      140,
      0
    );
  }
}