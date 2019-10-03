import 'package:umimamoru/domain/entity.dart';

class OccurPoles implements Entity {

  final List<String> _poles;

  OccurPoles(this._poles) : assert(_poles != null);

  List<String> get cones => _poles;
}