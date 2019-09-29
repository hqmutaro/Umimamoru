import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/module_state.dart';
import 'package:umimamoru/infrastructure/repository/module_state_repository.dart';

class ModuleStateBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>.broadcast();
  StreamController<List<ModuleState>> _outputController = StreamController<List<ModuleState>>.broadcast();

  StreamSink<void> get start => _startController.sink;
  Stream<List<ModuleState>> get output => _outputController.stream;

  String beach;

  ModuleStateBloc(String beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    ModuleStateRepository repository = ModuleStateRepository();
    var stream = Stream.periodic(const Duration(seconds: 5), (count) async{
      List<ModuleState> coneState = await repository.moduleState(this.beach);
      return coneState;
    });
    stream.listen((result) => result.then((coneState) {
      _outputController.sink.add(coneState);
    }));
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}