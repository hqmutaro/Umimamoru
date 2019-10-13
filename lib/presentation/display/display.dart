import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/image_action_bloc.dart';
import 'package:umimamoru/application/bloc/watching_bloc.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/presentation/display/state/map_state.dart';
import 'package:umimamoru/presentation/display/state/watching_button.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';
import 'package:umimamoru/presentation/ui/button/previous_button.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/occur_pole_bloc.dart';
import 'package:umimamoru/presentation/display/info/occur_pole_view.dart';
import 'package:umimamoru/presentation/display/state/header.dart';
import 'package:umimamoru/presentation/display/state/wave_level_bar.dart';
import 'package:umimamoru/presentation/display/info/module_state_view_list.dart';
import 'package:umimamoru/application/bloc/module_bloc.dart';
import 'package:umimamoru/presentation/display/info/image_action_view.dart';

class Display extends StatefulWidget {

  final Beach beach;

  const Display({
    Key key,
    @required this.beach
  }) :
      assert(beach != null),
      super(key: key);

  @override
  _Display createState() => _Display();
}

class _Display extends State<Display> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PreviousButton(message: "別の海水浴場に変更する"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.beach.pref + widget.beach.city + widget.beach.ward + "\n"
                  + widget.beach.name + "の海流のようす",
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              BlocProvider<ImageActionBloc>(
                  bloc: ImageActionBloc(widget.beach),
                  child: ImageActionView(beach: widget.beach.name)
              ),
              Header(title: "離岸流が発生している場所"),
              BlocProvider<OccurPoleBloc>(
                  bloc: OccurPoleBloc(widget.beach),
                  child: OccurPoleView(beach: widget.beach.name)
              ),
              Header(title: "海流のようす"),
              WaveLevelBar(),
              BlocProvider<ModuleBloc>(
                  bloc: ModuleBloc(widget.beach),
                  child: ModuleStateViewList(beach: widget.beach.name)
              )
            ]
          )
        )
      ),
      floatingActionButton: BlocProvider<WatchingBloc>(
        bloc: WatchingBloc(widget.beach.name),
        child: WatchingButton(beach: widget.beach.name)
      )
    );
  }
}