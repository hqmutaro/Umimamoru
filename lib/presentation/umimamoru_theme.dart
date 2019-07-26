import 'package:flutter/material.dart';

class UmimamoruTheme extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final List<Widget> widget;

  const UmimamoruTheme({
    @required this.title,
    this.widget = null,
    Key key
  }) : assert(title != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF4CBBB4),
      actions: this.widget,
      title: Text(
        this.title,
        style: TextStyle(
            color: Colors.white
        ),
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}