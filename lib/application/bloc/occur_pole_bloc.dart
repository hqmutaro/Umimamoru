import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/infrastructure/repository/server_occur_pole_repository.dart';

class OccurPoleBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<List<String>> _outputController = StreamController<List<String>>();

  StreamSink<void> get start => _startController.sink;
  Stream<List<String>> get output => _outputController.stream;

  Beach beach;

  OccurPoleBloc(Beach beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    var stream = Stream.periodic(const Duration(seconds: 5), (count) async{
      return await ServerOccurPoleRepository().occurState(this.beach);
    });
    stream.listen((result) => result.then((occurPole) {
      _outputController.sink.add(occurPole.cones);
    }));
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}