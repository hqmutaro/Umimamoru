import 'package:umimamoru/domain/module_state.dart';
import 'package:umimamoru/domain/occur_modules.dart';
import 'package:umimamoru/domain/repository/occur_state_repository.dart';
import 'package:umimamoru/infrastructure/repository/module_state_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';

class OccurModulesRepository implements OccurStateRepository {

  @override
  Future<OccurModules> occurState(String beach) async{
    List<String> occurModule = [];
    ModuleStateRepository repository = ModuleStateRepository();
    List<ModuleState> moduleState = await repository.moduleState(beach);
    moduleState.forEach((entity) {
      if (entity.level == getLevelToString(Level.Fast)) occurModule.add(entity.module);
    });
    return OccurModules(occurModule);
  }
}