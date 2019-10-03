import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/module.dart';
import 'package:umimamoru/infrastructure/repository/server_module_repository.dart';

class ModuleBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>.broadcast();
  StreamController<List<Module>> _outputController = StreamController<List<Module>>.broadcast();

  StreamSink<void> get start => _startController.sink;
  Stream<List<Module>> get output => _outputController.stream;

  Beach beach;

  ModuleBloc(Beach beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    ServerModuleRepository repository = ServerModuleRepository();
    var stream = Stream.periodic(const Duration(seconds: 5), (count) async{
      List<Module> moduleState = await repository.moduleState(this.beach);
      return moduleState;
    });
    stream.listen((result) => result.then((moduleState) {
      _outputController.sink.add(moduleState);
    }));
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}