import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/domain/wave_speed.dart';

@immutable
class WaveState {

  static double waveSpeed;

  const WaveState({
    @required waveSpeed
  }) : assert(waveSpeed != null);
}