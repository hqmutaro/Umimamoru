import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/cone_state.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/infrastructure/repository/cone_state_repository.dart';

class ImageActionBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<bool> _outputController = StreamController<bool>();

  StreamSink<void> get start => _startController.sink;
  Stream<bool> get output => _outputController.stream;

  String beach;

  ImageActionBloc(String beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    bool isOccurring = false;
    ConeStateRepository().coneState(this.beach).then((repository) {
      repository.forEach((coneState) {
        if (coneState.level == getLevelToString(Level.Fast)) {
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