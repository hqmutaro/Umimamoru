import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/image_action_bloc.dart';
import 'package:umimamoru/application/bloc/watching_bloc.dart';
import 'package:umimamoru/presentation/display/state/map_state.dart';
import 'package:umimamoru/presentation/display/watching_button.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';
import 'package:umimamoru/presentation/ui/button/previous_button.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/occur_cone_bloc.dart';
import 'package:umimamoru/presentation/display/info/occur_cone_view.dart';
import 'package:umimamoru/presentation/display/header.dart';
import 'package:umimamoru/presentation/display/wave_level_bar.dart';
import 'package:umimamoru/presentation/display/info/cone_state_view_list.dart';
import 'package:umimamoru/application/bloc/cone_state_bloc.dart';
import 'package:umimamoru/presentation/display/info/image_action_view.dart';

class Display extends StatefulWidget {

  final String beach;
  final String region;

  const Display({
    Key key,
    @required this.beach,
    @required this.region
  }) :
      assert(beach != null),
      assert(region != null),
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
                  widget.region + "\n" +
                  widget.beach + "の海流のようす",
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              BlocProvider<ImageActionBloc>(
                  bloc: ImageActionBloc(widget.beach),
                  child: ImageActionView(beach: widget.beach)
              ),
              Header(title: "離岸流が発生している場所"),
              BlocProvider<OccurConeBloc>(
                  bloc: OccurConeBloc(widget.beach),
                  child: OccurConeView(beach: widget.beach)
              ),
              Header(title: "海流のようす"),
              WaveLevelBar(),
              BlocProvider<ConeStateBloc>(
                  bloc: ConeStateBloc(widget.beach),
                  child: ConeStateViewList(beach: widget.beach)
              )
            ]
          )
        )
      ),
      floatingActionButton: BlocProvider<WatchingBloc>(
        bloc: WatchingBloc(widget.beach),
        child: WatchingButton(beach: widget.beach)
      )
    );
  }
}