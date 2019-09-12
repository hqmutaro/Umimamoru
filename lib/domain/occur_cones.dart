import 'package:umimamoru/domain/entity.dart';

class OccurCones implements Entity {

  final List<String> _cones;

  OccurCones(this._cones) : assert(_cones != null);

  List<String> get cones => _cones;
}