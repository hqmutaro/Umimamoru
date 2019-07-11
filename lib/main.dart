import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/select_region.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Umimamoru'),
      ),
      body:
      Center(
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 50.0),
              ),

              Text(
                "うみまもる",
                style: TextStyle(fontSize:49.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),

              Padding(
                padding: EdgeInsets.all(24.0),
              ),

              RaisedButton(key:null, onPressed:buttonPressed,
                  color: Color(0xFFe0e0e0),
                  child:
                  Text(
                    "地域を選択する",
                    style: TextStyle(fontSize:18.0,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto"),
                  )
              )
            ]

        ),

      ),

    );
  }

  buttonPressed(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchList()));
  }

}