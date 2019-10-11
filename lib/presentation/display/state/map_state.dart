import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/module_bloc.dart';
import 'package:umimamoru/domain/beach.dart';
import 'package:umimamoru/domain/module.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/presentation/ui/loader/color_loader.dart';
import 'package:umimamoru/presentation/ui/loader/color_loader3.dart';

class MapState extends StatefulWidget {

  final Beach beach;

  MapState({@required this.beach}) : assert(beach != null);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends  State<MapState> {

  Completer<GoogleMapController> _controller = Completer();
  LatLng _center;

  @override
  void initState() {
    super.initState();
    this._center = LatLng(widget.beach.latitude, widget.beach.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  double getIconPath(double speed) {
    if (getLevel(speed) == Level.Fast) {
      return BitmapDescriptor.hueRed;
    }

    if (getLevel(speed) == Level.Ordinarily) {
      return BitmapDescriptor.hueGreen;
    }

    if (getLevel(speed) == Level.Calm) {
      return BitmapDescriptor.hueBlue;
    }
    return BitmapDescriptor.hueYellow;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ModuleBloc>(context);
    bloc.start.add(null);

    return StreamBuilder<List<Module>>(
      stream: bloc.output,
      builder: (BuildContext context, AsyncSnapshot<List<Module>> snapshot) {
        if (snapshot.hasData) {
          List<Marker> allMarkers = [];
          snapshot.data.forEach((model) async {
            allMarkers.add(
                Marker(
                    markerId: MarkerId(model.id.toString()),
                    draggable: false,
                    position: LatLng(model.latitude, model.longitude),
                    infoWindow: InfoWindow(
                      title: model.id.toString() + "モジュール",
                      snippet: "流速: ${model.speed}m/s "//発生回数: ${model.countOccur}",
                    ),
                    /*
                    icon: await BitmapDescriptor.fromAssetImage(
                        ImageConfiguration(size: Size(100, 20)),
                        getIconPath(model.speed)
                    )
                    
                     */
                    icon: BitmapDescriptor.defaultMarkerWithHue(getIconPath(model.speed))
                )
            );
          });
          return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 17.0
              ),
              minMaxZoomPreference: MinMaxZoomPreference(16, 18),
              markers: allMarkers.toSet(),
              scrollGesturesEnabled: false,
              rotateGesturesEnabled: false,
              zoomGesturesEnabled: false,
              tiltGesturesEnabled: false,
              mapType: MapType.hybrid,
          );
        }
        return Container(
          child: Center(
            child: ColorLoader(
              colors: [Colors.blueAccent, Colors.pinkAccent],
              duration: Duration(milliseconds: 1250)
            )
          )
        );
      }
    );
  }
}