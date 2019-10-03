import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/module_bloc.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/presentation/display/display.dart';
import 'package:umimamoru/presentation/display/state/map_state.dart';

import '../umimamoru_theme.dart';

class DisplayHome extends StatefulWidget {

  final Beach beach;

  const DisplayHome({
    Key key,
    @required this.beach
  }) :
        assert(beach != null),
        super(key: key);

  @override
  _DisplayHome createState() => _DisplayHome();
}

class _DisplayHome extends State<DisplayHome> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(
          child: Text("詳細", style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.perm_device_information, color: Colors.white),
        ),
        Tab(
          child: Text("地図", style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.pin_drop, color: Colors.white),
        )
      ],
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      // Add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: UmimamoruTheme.colorTheme,
            title: Text(widget.beach.name, style: TextStyle(color: Colors.white)),
            bottom: getTabBar()
        ),
        body: getTabBarView(<Widget>[
          Display(beach: widget.beach),
          BlocProvider<ModuleBloc>(
              bloc: ModuleBloc(widget.beach),
              child: MapState()
          )
        ]
        )
    );
  }
}