import 'package:umimamoru/domain/entity.dart';

class OccurModules implements Entity {

  final List<String> _cones;

  OccurModules(this._cones) : assert(_cones != null);

  List<String> get cones => _cones;
}