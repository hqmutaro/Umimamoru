import 'dart:async';
import 'dart:convert';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/module.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/infrastructure/repository/dto/module_dto.dart';
import 'package:umimamoru/infrastructure/repository/server_module_repository.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';

class ImageActionBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<bool> _outputController = StreamController<bool>();

  StreamSink<void> get start => _startController.sink;
  Stream<bool> get output => _outputController.stream;

  Beach beach;

  ImageActionBloc(Beach beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() async{
    bool isOccurring = false;
    ServerModuleRepository repository = ServerModuleRepository();

    var stream = Stream.periodic(const Duration(seconds: 5), (count) async{
      List<Module> moduleState = await repository.moduleState(this.beach.name);
      return moduleState;
    });
    stream.listen((result) => result.then((moduleList) {
      moduleList.forEach((module) {
        if (module.level == getLevelToString(Level.Fast)) {
          isOccurring = true;
          _outputController.sink.add(isOccurring);
          return;
        }
      });
    }));
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}