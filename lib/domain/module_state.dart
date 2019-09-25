import 'package:umimamoru/domain/entity.dart';

class ModuleState implements Entity {

  final String _beach;
  final String _module;
  final String _waveLevel;
  final double _waveSpeed;
  final int _countOccur;
  final double _latitude;
  final double _longitude;

  ModuleState(
      this._beach,
      this._module,
      this._waveLevel,
      this._waveSpeed,
      this._countOccur,
      this._latitude,
      this._longitude
  ) :
      assert(_beach != null),
      assert(_module != null),
      assert(_waveLevel != null),
      assert(_waveSpeed != null),
      assert(_countOccur != null),
      assert(_latitude != null),
      assert(_longitude != null);

  String get beach => _beach;

  String get module => _module;

  String get level => _waveLevel;

  double get speed => _waveSpeed;

  int get countOccur => _countOccur;

  double get latitude => _latitude;

  double get longitude => _longitude;
}