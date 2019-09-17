import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/watching_bloc.dart';
import 'package:umimamoru/infrastructure/service/watch_provider.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';

class WatchingButton extends StatefulWidget {

  final String beach;

  WatchingButton({@required this.beach}) : assert(beach != null);

  @override
  _WatchingButton createState() => _WatchingButton();
}

class _WatchingButton extends State<WatchingButton> {

  Color _color;

  @override
  void initState() {
    super.initState();
    var provider = WatchProvider.getInstance();
    provider.existsBeach(widget.beach)
        .then((result) =>
        this._color = result ? Colors.redAccent : Colors.white
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WatchingBloc>(context);
    bloc.start.add(null);

    return StreamBuilder<bool>(
      stream: bloc.output,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return FloatingActionButton(
              heroTag: "btn1",
              onPressed: () async{
                setState(() {
                  if (snapshot.data) {
                    this._color = Colors.white;
                  }
                  else {
                    this._color = Colors.redAccent;
                  }
                });
                snapshot.data ? await unWatching() : await onWatching();
              },//onWatching,
              backgroundColor: UmimamoruTheme.colorTheme,
              child: Icon(
                  Icons.remove_red_eye,
                  color: this._color
              )
          );
        }
        return FloatingActionButton(
            heroTag: "btn2",
            onPressed: null,//onWatching,
            backgroundColor: UmimamoruTheme.colorTheme,
            child: Icon(
                Icons.remove_red_eye,
                color: Colors.grey
            )
        );
      }
    );
  }

  Future<void> onWatching() async{
    var provider = WatchProvider.getInstance();
    await provider.addBeach(widget.beach);
  }

  Future<void> unWatching() async{
    var provider = WatchProvider.getInstance();
    await provider.removeBeach(widget.beach);
  }
}