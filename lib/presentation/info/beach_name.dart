import 'package:flutter/material.dart';

@immutable
class BeachName extends StatelessWidget {

  final String region;
  final String beach;

  const BeachName({
    @required this.region,
    @required this.beach,
  }) : assert(region != null), assert(beach != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          this.region + "\n" +
          this.beach + "の波のようす",
          style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold
          )
        )
    );
  }
}