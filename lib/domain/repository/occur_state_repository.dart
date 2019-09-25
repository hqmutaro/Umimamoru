import 'package:umimamoru/domain/occur_modules.dart';

abstract class OccurStateRepository {
  Future<OccurModules> occurState(String beach);
}