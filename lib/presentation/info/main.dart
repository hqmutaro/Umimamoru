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
  Map state;
  String image;
  ConeStateRepository _coneStateRepository;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    this._coneStateRepository = ConeStateRepository(widget.beach);
    this.cone = [
      "4番コーン",
      "5番コーン"
    ];
    this.state = {
      "1番コーン" : {
    "state" : "calm",
    "wave.speed" : 3,
    "count.occur" : 2
    },
    "2番コーン" : {
    "state" : "ordinarily",
    "wave.speed" : 4,
    "count.occur" : 3
    },
    "3番コーン" : {
    "state" : "ordinarily",
    "wave.speed" : 5,
    "count.occur" : 4
    },
    "4番コーン" : {
    "state" : "fast",
    "wave.speed" : 6,
    "count.occur" : 5
    },
    "5番コーン" : {
    "state" : "fast",
    "wave.speed" : 7,
    "count.occur" : 5
    },
    };
    this.image = "rigan_bar";
  }

  updateState(Map updatedState) {
    setState(() {
      this.state = updatedState;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UmimamoruTheme(title: widget.beach),
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
                OccurCone(cone: this.cone,),
                Header(title: "波のようす"),
                WaveLevel(),
                ConeStateView(state: this.state)
              ]
          ),
        ),
      )
    );
  }
}