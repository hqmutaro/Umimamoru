import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';

class WatchingBeachBloc extends BlocBase {

  StreamController<void> _startController = StreamController<void>();
  StreamController<List<String>> _outputController = StreamController<List<String>>();

  StreamSink<void> get start => _startController.sink;

  Stream<List<String>> get output => _outputController.stream;

  WatchingBeachBloc() {
    _startController.stream.listen((_) async{
      await _start();
    });
  }

  Future<void> _start() async{
    var provider = WatchProvider.getInstance();
    var watchBeaches = await provider.getWatchBeaches();
    _outputController.sink.add(watchBeaches);
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}