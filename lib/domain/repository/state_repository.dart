import 'package:umimamoru/domain/module_state.dart';

abstract class StateRepository {
  Future<List<ModuleState>> moduleState(String beach);
}