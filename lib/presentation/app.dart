import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/title.dart' as title;

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF4CBBB4)
      ),
      home: title.Title(),
    );
  }
}