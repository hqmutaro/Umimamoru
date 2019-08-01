import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/umimamoru_theme.dart';
import 'package:umimamoru_flutter/presentation/back_bar.dart';
import 'package:umimamoru_flutter/presentation/info/beach_name.dart';
import 'package:umimamoru_flutter/presentation/info/state_image_bar.dart';
import 'package:umimamoru_flutter/presentation/info/header.dart';
import 'package:umimamoru_flutter/presentation/info/wave_level.dart';
import 'package:umimamoru_flutter/presentation/info/occur_cone.dart';
import 'package:umimamoru_flutter/presentation/info/cone_state_view.dart';
import 'package:umimamoru_flutter/application/repository/cone_state_repository.dart';
import 'package:umimamoru_flutter/infrastructure/server/cone_state_task.dart';
import 'package:umimamoru_flutter/presentation/info/cone_state_view_list.dart';
import 'package:umimamoru_flutter/domain/entity.dart';
import 'package:umimamoru_flutter/domain/cone_state.dart';

@immutable
class InfoDisplay extends StatefulWidget {

  final String beach;
  final String region;

  const InfoDisplay({
    @required this.beach,
    @required this.region
  }) : assert(beach != null), assert(region != null);

  @override
  _InfoDisplay createState() => _InfoDisplay();
}

class _InfoDisplay extends State<InfoDisplay> {

  List<String> cone;
  Map<String, Map<String, dynamic>> data;
  String image;
  Map<String, Entity> entities;

  @override
  void initState() {
    super.initState();
    init();
    updateEntities();
  }

  init() {
    //this._coneStateRepository = ConeStateRepository(id: widget.beach);
    //ConeStateTask(id: widget.beach, repository: this._coneStateRepository).createEntity();
    this.entities = {};
    this.cone = [
      "4番コーン",
      "5番コーン"
    ];
    this.data = {
      "1番コーン" : {
    "level" : "calm",
    "wave.speed" : 3.0,
    "count.occur" : 2
    },
    "2番コーン" : {
    "level" : "ordinarily",
    "wave.speed" : 4.0,
    "count.occur" : 3
    },
    "3番コーン" : {
    "level" : "ordinarily",
    "wave.speed" : 5.0,
    "count.occur" : 4
    },
    "4番コーン" : {
    "level" : "fast",
    "wave.speed" : 6.0,
    "count.occur" : 5
    },
    "5番コーン" : {
    "level" : "fast",
    "wave.speed" : 7.0,
    "count.occur" : 5
    },
    };
    this.image = "rigan_bar";
  }

  updateState(Map updatedState) {
    setState(() {
      this.data = updatedState;
    });
  }

  updateCone(List<String> updatedCone) {
    setState(() {
      this.cone = updatedCone;
    });
  }

  updateImage(String updatedImage) {
    setState(() {
      this.image = updatedImage;
    });
  }

  updateEntities() {
    Map<String, Entity> updatedEntities = {};
    var stream = new Stream.periodic(const Duration(seconds: 5), (count) {
      this.data.forEach((cone, data) =>
      updatedEntities[cone] = ConeState(widget.beach, cone, data["level"], data["wave.speed"], data["count.occur"])
      );
    });
    stream.listen((result) {
      if (this.mounted) {
        setState(() {
          this.entities = updatedEntities;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UmimamoruTheme(title: Text(widget.beach, style: TextStyle(color: Colors.white),)),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BackBar(message: "別のビーチに変更する"),
                BeachName(region: widget.region, beach: widget.beach),
                StateImageBar(image: this.image),
                Header(title: "離岸流が発生している場所"),
                OccurCone(cone: this.cone),
                Header(title: "波のようす"),
                WaveLevel(),
                ConeStateViewList(entities: this.entities)
              ]
          ),
        ),
      )
    );
  }
}