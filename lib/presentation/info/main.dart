import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umimamoru_flutter/presentation/info/state.dart' as state;

// ignore: must_be_immutable
class InfoDisplay extends StatefulWidget {
  String beach;
  String region;

  InfoDisplay(this.beach, this.region);

  @override
  state.InfoDisplayState createState() => state.InfoDisplayState();
}