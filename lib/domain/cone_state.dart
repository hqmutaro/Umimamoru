import 'package:umimamoru/domain/entity.dart';

class ConeState implements Entity {

  final String _beach;
  final String _cone;
  final String _waveLevel;
  final double _waveSpeed;
  final int _countOccur;

  ConeState(
      this._beach,
      this._cone,
      this._waveLevel,
      this._waveSpeed,
      this._countOccur
  ) :
      assert(_beach != null),
      assert(_cone != null),
      assert(_waveLevel != null),
      assert(_waveSpeed != null),
      assert(_countOccur != null);

  String get beach => _beach;

  String get cone => _cone;

  String get level => _waveLevel;

  double get speed => _waveSpeed;

  int get countOccur => _countOccur;
}