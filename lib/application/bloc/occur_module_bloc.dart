import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/infrastructure/repository/occur_modules.repository.dart';

class OccurModuleBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<List<String>> _outputController = StreamController<List<String>>();

  StreamSink<void> get start => _startController.sink;
  Stream<List<String>> get output => _outputController.stream;

  String beach;

  OccurModuleBloc(String beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    var stream = Stream.periodic(const Duration(seconds: 5), (count) async{
      return await OccurModulesRepository().occurState(this.beach);
    });
    stream.listen((result) => result.then((occurCone) {
      _outputController.sink.add(occurCone.cones);
    }));
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}