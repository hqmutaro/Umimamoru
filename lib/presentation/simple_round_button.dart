import 'package:flutter/material.dart';

class SimpleRoundButton extends StatelessWidget {

  final Color backgroundColor;
  final String buttonText;
  final Color textColor;
  final double textSize;
  final Function onPressed;

  final double width;
  final double height;

  SimpleRoundButton({
    this.backgroundColor,
    this.buttonText,
    this.textColor,
    this.textSize,
    this.onPressed,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
              splashColor: this.backgroundColor,
              color: this.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      this.buttonText,
                      style: TextStyle(
                          fontSize: this.textSize,
                          color: this.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: onPressed,
            ),
          )
        ],
      ),
    );
  }
}