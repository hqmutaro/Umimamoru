import 'package:flutter/material.dart';

class UmimamoruTheme extends StatelessWidget {

  final String title;
  final Widget home;

  const UmimamoruTheme({
    Key key,
    @required this.title,
    @required this.home,
  }) :
        assert(title != null),
        assert(home != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: this.title,
        theme: ThemeData(primaryColor: colorTheme),
        home: this.home
    );
  }

  static Color get colorTheme => Color(0xFF4CBBB4);
}