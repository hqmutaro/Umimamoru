import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/watching_beach_bloc.dart';
import 'package:umimamoru/application/debug.dart';
import 'package:umimamoru/infrastructure/repository/server_beach_repository.dart';
import 'package:umimamoru/infrastructure/repository/server_provider.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';
import 'package:umimamoru/presentation/display/main.dart';
import 'package:umimamoru/presentation/ui/loader/color_loader3.dart';

class WatchingList extends StatefulWidget {

  @override
  _WatchingList createState() => _WatchingList();
}

class _WatchingList extends State<WatchingList> {

  Map<String, bool> isDeleted = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WatchingBeachBloc>(context);
    bloc.start.add(null);

    return StreamBuilder<List<String>>(
      stream: bloc.output,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          snapshot.data.forEach((beach) => this.isDeleted[beach] = false);
          print(snapshot.data.toString());
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                  Icons.beach_access, color: Colors.pinkAccent),
                              foregroundColor: Colors.white
                          ),
                          title: Text(snapshot.data[index]),
                          subtitle: Text("沖縄県名護市辺野古"),
                          onTap: onTap(snapshot.data[index]),
                        ),
                      ),
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      actions: <Widget>[
                        IconSlideAction(
                          caption: "削除",
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: onDelete(bloc, snapshot.data[index])
                        )
                      ]
                  );
              }
            )
          );
        }
        return Text("");
      }
    );
  }

  Function onDelete(WatchingBeachBloc bloc, String beach) {
    return () async{
      var provider = WatchProvider.getInstance();
      await provider.removeBeach(beach);
      bloc.start.add(null);
    };
  }

  Function onTap(String beachName) {
    return () async{
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
      var beach = await ServerBeachRepository().beachData(beachName);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisplayHome(beach: beach))
      );
    };
  }

  void notActivityPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Text("サーバエラー"),
              content: Text("サーバがダウンしています。\n復旧までしばらくお待ちください。"),
              actions: <Widget>[
                RaisedButton(
                    onPressed: () => Navigator.pop(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    color: Colors.blue[800],
                    child: Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        )
                    )
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
                RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  color: Colors.blue[800],
                  child: Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      )
                  )
              )
              ]
          );
        }
    );
  }
}