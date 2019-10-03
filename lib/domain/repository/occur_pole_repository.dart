import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/occur_poles.dart';

abstract class OccurPoleRepository {
  Future<OccurPoles> occurState(Beach beach);
}