import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';

class OccurConeBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<List<String>> _outputController = StreamController<List<String>>();

  StreamSink<void> get start => _startController.sink;
  Stream<List<String>> get output => _outputController.stream;

  String beach;

  OccurConeBloc(String beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    var stream = Stream.periodic(const Duration(seconds: 5), (count) {
      return  [
        "2番コーン",
        "3番コーン"
      ];
    });
    stream.listen((result) {
      _outputController.sink.add(result);
    });
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}