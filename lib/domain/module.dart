import 'package:umimamoru/domain/entity.dart';

class Module implements Entity {

  final int _id;
  final String _waveLevel;
  final double _waveSpeed;
  final int _countOccur;
  final double _latitude;
  final double _longitude;

  Module(
      this._id,
      this._waveLevel,
      this._waveSpeed,
      this._countOccur,
      this._latitude,
      this._longitude
  ) :
      assert(_id != null),
      assert(_waveLevel != null),
      assert(_waveSpeed != null),
      assert(_countOccur != null),
      assert(_latitude != null),
      assert(_longitude != null);

  int get id => _id;

  String get level => _waveLevel;

  double get speed => _waveSpeed;

  int get countOccur => _countOccur;

  double get latitude => _latitude;

  double get longitude => _longitude;
}