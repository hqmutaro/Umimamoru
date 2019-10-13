import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/module.dart';

abstract class ModuleRepository {
  Future<List<Module>> moduleState(String beach);
}