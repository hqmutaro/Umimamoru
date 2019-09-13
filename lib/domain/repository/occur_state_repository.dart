import 'package:umimamoru/domain/occur_cones.dart';

abstract class OccurStateRepository {
  Future<OccurCones> occurState(String beach);
}