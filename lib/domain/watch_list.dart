import 'package:umimamoru/domain/entity.dart';

class WatchList implements Entity {

  final List<String> _watchList;

  WatchList(this._watchList) : assert(_watchList != null);

  List<String> get watchList => _watchList;
}