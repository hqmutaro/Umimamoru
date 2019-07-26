import 'package:flutter/material.dart';

@immutable
class BackBar extends StatelessWidget with PreferredSizeWidget {

  String message;
  BackBar({@required this.message}) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: 10.0
    ),
      child: Row(children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: FloatingActionButton(
              onPressed: () => Navigator.of(context).pop(),
              backgroundColor: Color(0xFF66BAB7),
              child: Icon(Icons.arrow_back),
            ),
          ),
          SizedBox(width: 20),
          Text(this.message,
              style: TextStyle(fontSize: 20.0)
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}