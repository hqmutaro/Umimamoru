import 'package:flutter/cupertino.dart';
import 'package:umimamoru/domain/entity.dart';

class Pole implements Entity {

  final int _net;
  final int _loc;
  final double _waveSpeed;
  final double _latitude;
  final double _longitude;

  Pole(
    this._net,
    this._loc,
    this._waveSpeed,
    this._latitude,
    this._longitude
  ) :
        assert(_net != null),
        assert(_loc != null),
        assert(_waveSpeed != null),
        assert(_latitude != null),
        assert(_longitude != null);

  int get net => _net;

  int get loc => _loc;

  double get speed => _waveSpeed;

  double get latitude => _latitude;

  double get longitude => _longitude;
}