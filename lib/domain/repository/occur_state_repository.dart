import '../occur_cones.dart';

abstract class OccurStateRepository {
  Future<OccurCones> occurState(String beach);
}