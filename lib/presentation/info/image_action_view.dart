import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/image_action_bloc.dart';

class ImageActionView extends StatelessWidget {

  final String beach;

  ImageActionView({@required this.beach});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ImageActionBloc>(context);
    bloc.start.add(null);

    return StreamBuilder<bool>(
      stream: bloc.output,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Container(
            child: Image.asset(
                snapshot.data ? 'images/warning.png' : 'images/safe.png',
                fit:BoxFit.fitWidth
            ),
            alignment: Alignment.center
        );
      }
    );
  }
}