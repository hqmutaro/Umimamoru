import 'package:flutter/material.dart';

class ImageActionView extends StatelessWidget {

  const ImageActionView();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(
            'images/warning.png',
            fit:BoxFit.fitWidth
        ),
        alignment: Alignment.center
    );
  }
}