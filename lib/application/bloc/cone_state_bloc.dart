import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/cone_state.dart';
import 'package:umimamoru/infrastructure/repository/cone_state_repository.dart';

class ConeStateBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<List<ConeState>> _outputController = StreamController<List<ConeState>>();

  StreamSink<void> get start => _startController.sink;
  Stream<List<ConeState>> get output => _outputController.stream;

  String beach;

  ConeStateBloc(String beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    ConeStateRepository repository = ConeStateRepository();
    var stream = Stream.periodic(const Duration(seconds: 5), (count) async{
      List<ConeState> coneState = await repository.coneState(this.beach);
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