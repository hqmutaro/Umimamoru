import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';

class WatchingBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<bool> _outputController = StreamController<bool>();

  StreamSink<void> get start => _startController.sink;

  Stream<bool> get output => _outputController.stream;

  String beach;

  WatchingBloc(String beach) {
    this.beach = beach;
    _startController.stream.listen((_) => _start());
  }

  void _start() {
    var provider = WatchProvider.getInstance();
    provider.existsBeach(this.beach)
        .then((result) =>
        _outputController.sink.add(result));
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}