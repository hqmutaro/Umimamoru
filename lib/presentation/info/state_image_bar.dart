import 'package:flutter/material.dart';

class StateImageBar extends StatelessWidget {

  String image;

  StateImageBar({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'images/${this.image}.png',
        fit:BoxFit.fitWidth
      ),
      alignment: Alignment.center
    );
  }
}