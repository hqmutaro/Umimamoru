import 'dart:async';
import 'package:umimamoru/application/bloc/bloc_base.dart';
import 'package:umimamoru/domain/cone_state.dart';
import 'package:umimamoru/domain/wave_speed.dart';

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
    var stream = Stream.periodic(const Duration(seconds: 5), (count) {
      var result = {
        "アイウエオビーチ" : {
          "1番コーン": {
            "wave.speed": 0.3,
            "count.occur": 3
          },
          "2番コーン": {
            "wave.speed": 0.5,
            "count.occur": 1
          },
          "3番コーン": {
            "wave.speed": 0.8,
            "count.occur": 4
          },
          "4番コーン": {
            "wave.speed": 1.4,
            "count.occur": 3
          },
          "5番コーン": {
            "wave.speed": 1.8,
            "count.occur": 2
          }
        },
        "カキクケコビーチ" : {
          "1番コーン": {
            "wave.speed": 0.2,
            "count.occur": 2
          },
          "2番コーン": {
            "wave.speed": 1.2,
            "count.occur": 2
          },
          "3番コーン": {
            "wave.speed": 1.6,
            "count.occur": 6
          },
          "4番コーン": {
            "wave.speed": 1.3,
            "count.occur": 2
          },
          "5番コーン": {
            "wave.speed": 0.3,
            "count.occur": 2
          }
        }
      };
      return result[this.beach];
    });
    stream.listen((result) {
      List<ConeState> entities = [];
      result.forEach((cone, data) {
        entities.add(
            ConeState(
                this.beach,
                cone,
                getLevelToString(getLevel(data["wave.speed"])),
                data["wave.speed"],
                data["count.occur"]
            )
        );
      });
      _outputController.sink.add(entities);
    });
  }

  @override
  void dispose() async{
    await _startController.close();
    await _outputController.close();
  }
}