import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/watching_beach_bloc.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';
import 'package:umimamoru/presentation/info/main.dart';

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
                              backgroundColor: Colors.indigo,
                              child: Icon(
                                  Icons.beach_access, color: Colors.pinkAccent),
                              foregroundColor: Colors.white
                          ),
                          title: Text(snapshot.data[index]),
                          subtitle: Text("沖縄県名護市辺野古"),
                          onTap: onTap(snapshot.data[index], "沖縄県名護市辺野古"),
                        ),
                      ),
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      actions: <Widget>[
                        IconSlideAction(
                          caption: "削除",
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: onDelete(bloc, snapshot.data[index]),
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

  Function onTap(String beach, String region) {
    return () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Info(beach: beach, region: region))
      );
    };
  }
}