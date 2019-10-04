import 'package:umimamoru/domain/beach.dart';

abstract class BeachRepository {
  Future<Beach> beachData(String beach);
}