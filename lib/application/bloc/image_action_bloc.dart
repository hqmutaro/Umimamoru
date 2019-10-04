import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/infrastructure/repository/server_module_repository.dart';

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

  void _start() {
    bool isOccurring = false;
    var repository = ServerModuleRepository();
    repository.moduleState(this.beach).then((repository) {
      repository.forEach((module) {
        if (module.level == getLevelToString(Level.Fast)) {
          isOccurring = true;
          _outputController.sink.add(isOccurring);
          return;
        }
      });
      _outputController.sink.add(isOccurring);
    });
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}