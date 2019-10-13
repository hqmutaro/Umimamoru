import 'package:umimamoru/domain/entity.dart';

class Beach implements Entity {

  final String _name;
  final String _pref;
  final String _city;
  final String _ward;
  final double _latitude;
  final double _longitude;
  final int _net;

  Beach(
      this._name,
      this._pref,
      this._city,
      this._ward,
      this._latitude,
      this._longitude,
      this._net
  ) :
      assert(_name != null),
      assert(_pref != null),
      assert(_city != null),
      assert(_ward != null),
      assert(_latitude != null),
      assert(_longitude != null),
      assert(_net != null);

  String get name => _name;

  String get pref => _pref;

  String get city => _city;

  String get ward => _ward;

  double get latitude => _latitude;

  double get longitude => _longitude;

  int get net => _net;
}