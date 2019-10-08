import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/pole.dart';
import 'package:umimamoru/infrastructure/repository/server_pole_repository.dart';
import 'package:umimamoru/domain/wave_speed.dart';

class OccurPoleBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<List<Pole>> _outputController = StreamController<List<Pole>>();

  StreamSink<void> get start => _startController.sink;
  Stream<List<Pole>> get output => _outputController.stream;

  Beach beach;

  OccurPoleBloc(Beach beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    var stream = Stream.periodic(const Duration(seconds: 5), (count) async{
      return await ServerPoleRepository().poleState(this.beach);
    });
    stream.listen((result) => result.then((poleList) {
      _outputController.sink.add(getOccurPoles(poleList));
    }));
  }

  List<Pole> getOccurPoles(List<Pole> poleList) {
    var occurPoleList = <Pole>[];
    poleList.forEach((pole) {
      if (getLevel(pole.speed) == Level.Fast) {
        occurPoleList.add(pole);
      }
    });
    return occurPoleList;
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}