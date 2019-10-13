import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/pole.dart';

abstract class PoleRepository {
  Future<List<Pole>> poleState(String beach);
}