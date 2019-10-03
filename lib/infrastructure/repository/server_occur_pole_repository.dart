import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/module.dart';
import 'package:umimamoru/domain/occur_poles.dart';
import 'package:umimamoru/domain/repository/occur_pole_repository.dart';
import 'package:umimamoru/infrastructure/repository/server_module_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';

class ServerOccurPoleRepository implements OccurPoleRepository {

  @override
  Future<OccurPoles> occurState(Beach beach) async{
    List<String> occurModule = [];
    ServerModuleRepository repository = ServerModuleRepository();
    List<Module> moduleState = await repository.moduleState(beach);
    moduleState.forEach((entity) {
      if (entity.level == getLevelToString(Level.Fast)) occurModule.add(entity.id.toString());
    });
    return OccurPoles(occurModule);
  }
}