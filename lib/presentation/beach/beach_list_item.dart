import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/infrastructure/repository/server_beach_repository.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/presentation/beach/main.dart';
import 'package:umimamoru/domain/beach.dart' as beach;
import 'package:umimamoru/presentation/display/main.dart';
import 'package:umimamoru/presentation/ui/loader/color_loader3.dart';

@immutable
class BeachListItem extends StatelessWidget {

  final String beachName;
  final String region;

  final BeachState beachState;
  
  const BeachListItem({
    @required this.beachName,
    @required this.region,
    @required this.beachState
  }) :
      assert(beachName != null),
      assert(region != null),
      assert(beachState != null);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.beach_access, color: Colors.pinkAccent),
        title: Text(this.beachName, style: TextStyle(fontSize: 25.0)),
        subtitle: Text(this.region, style: TextStyle(color: Colors.grey)),
        onTap: () async{
          progressDialog(context);
          if (!Debug.isDebugMode()) {
            var connectivityResult = await Connectivity().checkConnectivity();
            if (connectivityResult == ConnectivityResult.none) {
              Navigator.pop(context);
              notConnectedPopup(context);
              return;
            }
            if (!await ServerProvider().isActivity()) {
              Navigator.pop(context);
              notActivityPopup(context);
              return;
            }
          }
          var beach = await ServerBeachRepository().beachData(this.beachName);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DisplayHome(beach: beach))
          );
          this.beachState.handleSearchFinish();
        }
      )
    );
  }

  void notActivityPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Text("サーバエラー"),
              content: Text("サーバがダウンしています。\n復旧までしばらくお待ちください。"),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context),
                )
              ]
          );
        }
    );
  }

  void progressDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ColorLoader3(
                            radius: 20.0,
                            dotRadius: 5.0
                        ),
                        Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text("読み込み中...")
                        ),
                        RaisedButton(
                          onPressed: () => Navigator.pop(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          color: Colors.blue[800],
                          child: Text(
                            "キャンセル",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            )
                          )
                        )
                      ]
                  )
              )
          );
        }
    );
  }

  void notConnectedPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("ネットワークエラー"),
          content: Text("インターネットに接続してください"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ]
        );
      }
    );
  }
}