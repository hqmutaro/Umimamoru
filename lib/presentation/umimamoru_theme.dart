import 'package:flutter/material.dart';

class UmimamoruTheme extends StatelessWidget implements PreferredSizeWidget {

  final Widget title;
  final List<Widget> widget;

  const UmimamoruTheme({
    @required this.title,
    this.widget,
    Key key
  }) : assert(title != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF4CBBB4),
      actions: this.widget,
      title: this.title,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}