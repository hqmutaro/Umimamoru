import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/application/repository/cone_state_repository.dart';
import 'package:umimamoru_flutter/presentation/info/cone_state_view.dart';
import 'package:umimamoru_flutter/domain/entity.dart';
import 'package:umimamoru_flutter/presentation/loader.dart';

class ConeStateViewList extends StatelessWidget {

  Map<String, Entity> entities;

  ConeStateViewList({@required this.entities}) : assert(entities != null);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (this.entities.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(20.0),
        child: Loader(colors: [Colors.red, Colors.blue], duration: Duration(milliseconds: 1000))
      );
    }

    this.entities.forEach((cone, entity) => widgets.add(ConeStateView(cone: cone, entity: entity)));

    return Column(children: widgets);
  }
}