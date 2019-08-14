import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';

class PreviousButton extends StatelessWidget {

  final String message;
  final List<Widget> action;

  const PreviousButton({
    @required this.message,
    this.action
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 5.0,
          left: 20.0,
          right: 20.0
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: FloatingActionButton(
              onPressed: () => Navigator.of(context).pop(),
              backgroundColor: UmimamoruTheme.colorTheme,
              child: Icon(Icons.arrow_back),
            )
          ),
          SizedBox(width: 20),
          Text(
              this.message,
              style: TextStyle(fontSize: 20.0)
          )
        ]
      )
    );
  }
}